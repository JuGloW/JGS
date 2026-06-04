#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: bash scripts/upload_server_package.sh <host-alias-or-user@host> [package-tar-gz] [remote-root] [port]"
  exit 2
fi

HOST_ALIAS="$1"
PACKAGE="${2:-dist/haijun-server-package.tar.gz}"
REMOTE_ROOT="${3:-~/haijun-ai}"
PORT="${4:-22}"

cd "$(dirname "$0")/.."

if [[ ! -f "$PACKAGE" ]]; then
  bash scripts/pack_server_package.sh server-package "$PACKAGE"
fi

echo "Creating remote root: $REMOTE_ROOT"
ssh -p "$PORT" "$HOST_ALIAS" "mkdir -p $REMOTE_ROOT"

echo "Uploading $PACKAGE to $HOST_ALIAS:$REMOTE_ROOT/"
scp -P "$PORT" "$PACKAGE" "$HOST_ALIAS:$REMOTE_ROOT/haijun-server-package.tar.gz"

cat <<EOF
Upload complete.
Next on server:
  cd $REMOTE_ROOT
  rm -rf server-package
  mkdir -p server-package
  tar -xzf haijun-server-package.tar.gz -C server-package
  cd server-package
  bash remote/server/validate_server_package.sh
  bash remote/server/bootstrap_server_cpu.sh
EOF

