#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

for tool in as ld qemu-system-x86_64 timeout; do
  command -v "$tool" >/dev/null || { echo "Dependência ausente: $tool" >&2; exit 2; }
done

echo "QEMU: $(qemu-system-x86_64 --version | head -n 1)"
echo "Plataforma declarada: arquitetura=x86_64; maquina=pc (BIOS legado); CPU=qemu64; RAM=128 MiB"

as --32 "$ROOT/tests/boot-poc/boot.s" -o "$WORK/boot.o"
ld -m elf_i386 -Ttext 0x7c00 --oformat binary -e _start "$WORK/boot.o" -o "$WORK/boot.img"

size="$(wc -c < "$WORK/boot.img" | tr -d ' ')"
[[ "$size" == "512" ]] || { echo "FAIL: boot image is $size bytes, esperados: 512" >&2; exit 1; }
signature="$(od -An -tx1 -j510 -N2 "$WORK/boot.img" | tr -d ' \n')"
[[ "$signature" == "55aa" ]] || { echo "FAIL: assinatura de inicialização inválida: $signature" >&2; exit 1; }

set +e
output="$(timeout 5s qemu-system-x86_64 \
  -drive "format=raw,file=$WORK/boot.img,if=ide" \
  -machine pc -cpu qemu64 -m 128M \
  -boot order=c -display none -serial none \
  -debugcon stdio -global isa-debugcon.iobase=0xe9 \
  -no-reboot -no-shutdown 2>&1)"
qemu_rc=$?
set -e

printf '%s\n' "$output"
[[ "$qemu_rc" == "124" ]] || { echo "FAIL: era esperado que o sistema convidado parasse até o tempo limite; código de saída do QEMU=$qemu_rc" >&2; exit 1; }
grep -Fq "ZupiOS: inicialização no QEMU aprovada" <<< "$output" || { echo "FAIL: mensagem de inicialização não encontrada" >&2; exit 1; }
echo "APROVADO: imagem=512 bytes; assinatura=55aa; marcador=presente; timeout=esperado; maquina=pc; CPU=qemu64; RAM=128 MiB"
