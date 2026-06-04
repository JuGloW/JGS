#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: bash scripts/inspect_gpu_server.sh <host-alias-or-user@host> [remote-package-root] [port]"
  exit 2
fi

HOST_ALIAS="$1"
REMOTE_PACKAGE_ROOT="${2:-~/haijun-ai/server-package}"
PORT="${3:-22}"

echo "Inspecting remote server through SSH:"
echo "  host: $HOST_ALIAS"
echo "  remote_package_root: $REMOTE_PACKAGE_ROOT"
echo "  port: $PORT"
echo

ssh -p "$PORT" "$HOST_ALIAS" "cd $REMOTE_PACKAGE_ROOT && bash remote/server/inspect_server.sh"
