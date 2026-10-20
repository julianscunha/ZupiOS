#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
count="${1:-5}"

if [[ ! "$count" =~ ^[1-9][0-9]*$ ]]; then
  echo "Usage: $0 [positive-number-of-runs]" >&2
  exit 2
fi

passed=0
for ((attempt = 1; attempt <= count; attempt++)); do
  printf '\n=== Run %d/%d ===\n' "$attempt" "$count"
  if bash "$ROOT/tests/boot-poc/run.sh"; then
    ((passed += 1))
  else
    rc=$?
    printf 'FAIL: run %d/%d exited with code %d; prior passes: %d/%d\n' "$attempt" "$count" "$rc" "$passed" "$count" >&2
    exit "$rc"
  fi
done

printf '\nPASS: %d/%d consecutive runs completed.\n' "$passed" "$count"
