#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
count="${1:-5}"
if [[ ! "$count" =~ ^[1-9][0-9]*$ ]]; then
  echo "Uso: $0 [quantidade-positiva-de-execucoes]" >&2
  exit 2
fi
passed=0
for ((attempt = 1; attempt <= count; attempt++)); do
  printf '\n=== Execu??o %d/%d ===\n' "$attempt" "$count"
  if bash "$ROOT/tests/boot-poc/run.sh"; then
    ((passed += 1))
  else
    rc=$?
    printf 'FALHA: execu??o %d/%d terminou com c?digo %d; aprovadas antes da falha: %d/%d\n' "$attempt" "$count" "$rc" "$passed" "$count" >&2
    exit "$rc"
  fi
done
printf '\nAPROVADO: %d/%d execu??es consecutivas conclu?das.\n' "$passed" "$count"
