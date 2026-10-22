#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
WORK="$(mktemp -d)"
KEEP_WORK="${KEEP_WORK:-0}"
cleanup() {
  if [[ "$KEEP_WORK" == "1" ]]; then
    echo "SYSTEM_POC_ARTIFACT_DIR=$WORK"
  else
    rm -rf "$WORK"
  fi
}
trap cleanup EXIT

for tool in qemu-system-x86_64 cpio gzip timeout find grep; do
  command -v "$tool" >/dev/null 2>&1 || { echo "ERROR: required tool not found: $tool" >&2; exit 2; }
done

KERNEL="${ZUPIOS_KERNEL:-}"
if [[ -z "$KERNEL" ]]; then
  for candidate in /boot/vmlinuz-*; do
    if [[ -f "$candidate" ]]; then KERNEL="$candidate"; break; fi
  done
fi
[[ -n "$KERNEL" && -f "$KERNEL" ]] || { echo "ERROR: no Linux kernel image found in /boot; install linux-image-generic or set ZUPIOS_KERNEL" >&2; exit 2; }
command -v busybox >/dev/null 2>&1 || { echo "ERROR: busybox not found; install busybox-static" >&2; exit 2; }

mkdir -p "$WORK/root/bin" "$WORK/root/dev" "$WORK/root/proc" "$WORK/root/sys"
cp "$(command -v busybox)" "$WORK/root/bin/busybox"
ln -s busybox "$WORK/root/bin/sh"
cat > "$WORK/root/init" <<'INIT'
#!/bin/sh
/bin/busybox mount -t proc proc /proc 2>/dev/null || true
/bin/busybox mount -t sysfs sysfs /sys 2>/dev/null || true
/bin/busybox mount -t devtmpfs devtmpfs /dev 2>/dev/null || true
echo "ZUPIOS_SYSTEM_BOOT_OK"
echo "ZUPIOS_INITRAMFS_PID=$$"
/bin/busybox sleep 1
echo "ZUPIOS_SYSTEM_SHUTDOWN"
exec /bin/busybox poweroff -f
INIT
chmod +x "$WORK/root/init"

(
  cd "$WORK/root"
  find . -print0 | cpio --null --create --format=newc --quiet | gzip -9 > "$WORK/initramfs.cpio.gz"
)

QEMU_VERSION="$(qemu-system-x86_64 --version | head -n 1)"
KERNEL_VERSION="$(basename "$KERNEL")"
KERNEL_BYTES="$(wc -c < "$KERNEL" | tr -d ' ')"
INITRAMFS_BYTES="$(wc -c < "$WORK/initramfs.cpio.gz" | tr -d ' ')"
LOG="$WORK/qemu-serial.log"

echo "SYSTEM_POC_QEMU_VERSION=$QEMU_VERSION"
echo "SYSTEM_POC_KERNEL=$KERNEL_VERSION"
echo "SYSTEM_POC_KERNEL_BYTES=$KERNEL_BYTES"
echo "SYSTEM_POC_INITRAMFS_BYTES=$INITRAMFS_BYTES"
echo "SYSTEM_POC_PROFILE= x86_64 / QEMU TCG / 256 MiB / serial console"

set +e
timeout --signal=TERM --kill-after=3s 20s qemu-system-x86_64 \
  -machine pc,accel=tcg -cpu qemu64 -m 256M \
  -kernel "$KERNEL" -initrd "$WORK/initramfs.cpio.gz" \
  -append 'console=ttyS0 rdinit=/init panic=-1' \
  -display none -serial stdio -monitor none -no-reboot >"$LOG" 2>&1
QEMU_STATUS=$?
set -e
cat "$LOG"

if ! grep -Fq 'ZUPIOS_SYSTEM_BOOT_OK' "$LOG"; then
  echo "ERROR: kernel/initramfs boot marker not observed (QEMU exit=$QEMU_STATUS)" >&2
  exit 1
fi
if ! grep -Fq 'ZUPIOS_SYSTEM_SHUTDOWN' "$LOG"; then
  echo "ERROR: initramfs did not reach the shutdown marker" >&2
  exit 1
fi

echo "SYSTEM_POC_RESULT=PASS"
echo "SYSTEM_POC_QEMU_EXIT=$QEMU_STATUS"
