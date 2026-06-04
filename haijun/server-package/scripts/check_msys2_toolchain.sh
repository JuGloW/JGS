#!/usr/bin/env bash
set -euo pipefail

echo "Haijun MSYS2 MINGW64 toolchain check"
echo "shell: ${SHELL:-unknown}"
echo "pwd: $(pwd)"
echo

check_tool() {
  local name="$1"
  if command -v "$name" >/dev/null 2>&1; then
    printf "ok:      %-8s %s\n" "$name" "$(command -v "$name")"
  else
    printf "missing: %-8s install/enable this before server upload\n" "$name"
  fi
}

check_tool bash
check_tool tar
check_tool ssh
check_tool scp

echo
echo "Expected local project path in MSYS2:"
echo '  /d/github AI/haijun-ai'
echo
echo "Expected real server path:"
echo '  ~/haijun-ai/server-package'
