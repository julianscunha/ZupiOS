#!/usr/bin/env python3
"""Capture QEMU output until a guest debug-console marker, with monotonic timing."""
import selectors
import subprocess
import sys
import time

TIMEOUT_SECONDS = 5.0

def main() -> int:
    if len(sys.argv) < 4 or sys.argv[2] != "--":
        print("usage: capture_marker.py MARKER -- COMMAND [ARG ...]", file=sys.stderr)
        return 2
    marker = sys.argv[1].encode()
    started = time.monotonic()
    proc = subprocess.Popen(sys.argv[3:], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, bufsize=0)
    assert proc.stdout is not None
    output = bytearray()
    with selectors.DefaultSelector() as selector:
        selector.register(proc.stdout, selectors.EVENT_READ)
        while time.monotonic() - started < TIMEOUT_SECONDS:
            if proc.poll() is not None:
                break
            events = selector.select(min(0.05, TIMEOUT_SECONDS - (time.monotonic() - started)))
            for key, _ in events:
                chunk = key.fileobj.read1(4096) if hasattr(key.fileobj, "read1") else key.fileobj.read(4096)
                if chunk:
                    output.extend(chunk)
                    if marker in output:
                        elapsed = time.monotonic() - started
                        proc.terminate()
                        try:
                            proc.wait(timeout=1)
                        except subprocess.TimeoutExpired:
                            proc.kill()
                            proc.wait()
                        sys.stdout.buffer.write(output)
                        if not output.endswith(b"\n"):
                            sys.stdout.buffer.write(b"\n")
                        print(f"MARKER_ELAPSED_SECONDS={elapsed:.6f}")
                        return 0
        if proc.poll() is None:
            proc.terminate()
            try:
                proc.wait(timeout=1)
            except subprocess.TimeoutExpired:
                proc.kill()
                proc.wait()
    sys.stdout.buffer.write(output)
    if not output.endswith(b"\n"):
        sys.stdout.buffer.write(b"\n")
    print(f"MARKER_NOT_FOUND_WITHIN_SECONDS={TIMEOUT_SECONDS:.1f}", file=sys.stderr)
    return 124

if __name__ == "__main__":
    raise SystemExit(main())
