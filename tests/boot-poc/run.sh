#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

for tool in as ld qemu-system-x86_64 timeout dd; do
  command -v "$tool" >/dev/null || { echo "Missing dependency: $tool" >&2; exit 2; }
done

echo "QEMU: $(qemu-system-x86_64 --version | head -n 1)"
echo "Declared platform: architecture=x86_64; machine=pc (legacy BIOS); CPU=qemu64; RAM=128 MiB"

as --32 "$ROOT/tests/boot-poc/boot.s" -o "$WORK/boot.o"
ld -m elf_i386 -Ttext 0x7c00 --oformat binary -e _start "$WORK/boot.o" -o "$WORK/boot.bin"
as --32 "$ROOT/tests/boot-poc/stage2.s" -o "$WORK/stage2.o"
ld -m elf_i386 -Ttext 0x8000 --oformat binary -e _start "$WORK/stage2.o" -o "$WORK/stage2.bin"

boot_size="$(wc -c < "$WORK/boot.bin" | tr -d ' ')"
stage2_size="$(wc -c < "$WORK/stage2.bin" | tr -d ' ')"
[[ "$boot_size" == "512" ]] || { echo "FAIL: boot sector is $boot_size bytes; expected 512" >&2; exit 1; }
[[ "$stage2_size" -le 512 ]] || { echo "FAIL: second stage is $stage2_size bytes; maximum is 512" >&2; exit 1; }
signature="$(od -An -tx1 -j510 -N2 "$WORK/boot.bin" | tr -d ' \n')"
[[ "$signature" == "55aa" ]] || { echo "FAIL: invalid boot signature: $signature" >&2; exit 1; }

dd if=/dev/zero of="$WORK/boot.img" bs=512 count=2 status=none
dd if="$WORK/boot.bin" of="$WORK/boot.img" conv=notrunc status=none
dd if="$WORK/stage2.bin" of="$WORK/boot.img" bs=512 seek=1 conv=notrunc status=none
image_size="$(wc -c < "$WORK/boot.img" | tr -d ' ')"
[[ "$image_size" == "1024" ]] || { echo "FAIL: disk image is $image_size bytes; expected 1024" >&2; exit 1; }

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
[[ "$qemu_rc" == "124" ]] || { echo "FAIL: expected guest to halt until timeout; QEMU exit code=$qemu_rc" >&2; exit 1; }
grep -Fq "ZupiOS: segundo estagio carregado e executado" <<< "$output" || { echo "FAIL: second-stage marker not found" >&2; exit 1; }
if grep -Fq "ZupiOS: falha ao carregar segundo estagio" <<< "$output"; then
  echo "FAIL: BIOS disk read reported an error" >&2
  exit 1
fi
echo "PASS: image=1024 bytes; boot sector=512; signature=55aa; second-stage-size=$stage2_size; second-stage-marker=present; timeout=expected; machine=pc; CPU=qemu64; RAM=128 MiB"
