#!/usr/bin/env bash
set -euo pipefail

echo "ZupiOS development environment check"
echo "OS: $(. /etc/os-release && printf '%s %s' "$NAME" "$VERSION_ID")"
echo "Architecture: $(uname -m)"
echo "Git: $(git --version)"
echo "Shell: $BASH_VERSION"
echo
echo "Environment check passed. No ZupiOS runtime or target boot image is implemented yet."
