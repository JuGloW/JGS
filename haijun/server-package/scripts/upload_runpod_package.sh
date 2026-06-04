#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  cat <<'EOF'
usage:
  bash scripts/upload_runpod_package.sh <host> <port> [user] [ssh-key] [package-zip]

example:
  bash scripts/upload_runpod_package.sh 1.2.3.4 12345 root ~/.ssh/haijun_runpod

This uploads Haijun to /workspace/haijun-ai/server-package on RunPod and runs
remote/server/first_run_server.sh. It does not download models or start training.
EOF
  exit 2
fi

HOST="$1"
PORT="$2"
USER_NAME="${3:-root}"
SSH_KEY="${4:-$HOME/.ssh/haijun_runpod}"
PACKAGE_ZIP="${5:-dist/haijun-server-package.zip}"
REMOTE_ROOT="/workspace/haijun-ai"
REMOTE_PACKAGE="$REMOTE_ROOT/server-package"

cd "$(dirname "$0")/.."

if [[ ! -f "$SSH_KEY" ]]; then
  echo "missing SSH key: $SSH_KEY"
  exit 1
fi

if [[ ! -f "$PACKAGE_ZIP" ]]; then
  echo "missing package zip: $PACKAGE_ZIP"
  echo "run: powershell -ExecutionPolicy Bypass -File scripts\\Pack-ServerPackage.ps1"
  exit 1
fi

echo "== Haijun RunPod upload =="
echo "host: $HOST"
echo "port: $PORT"
echo "user: $USER_NAME"
echo "ssh_key: $SSH_KEY"
echo "package_zip: $PACKAGE_ZIP"
echo "remote_package: $REMOTE_PACKAGE"
echo

echo "== SSH preflight =="
ssh -i "$SSH_KEY" -p "$PORT" \
  -o StrictHostKeyChecking=accept-new \
  -o ServerAliveInterval=30 \
  "$USER_NAME@$HOST" \
  "hostname && pwd && mkdir -p '$REMOTE_ROOT'"

echo
echo "== Upload package =="
scp -i "$SSH_KEY" -P "$PORT" \
  -o StrictHostKeyChecking=accept-new \
  "$PACKAGE_ZIP" \
  "$USER_NAME@$HOST:$REMOTE_ROOT/haijun-server-package.zip"

echo
echo "== Extract and first-run =="
ssh -i "$SSH_KEY" -p "$PORT" \
  -o StrictHostKeyChecking=accept-new \
  -o ServerAliveInterval=30 \
  "$USER_NAME@$HOST" \
  "cd '$REMOTE_ROOT' && rm -rf server-package && mkdir -p server-package && python3 -m zipfile -e haijun-server-package.zip server-package && cd server-package && bash remote/server/first_run_server.sh"

echo
echo "OK: RunPod upload and first-run completed."
echo "Remote package root: $REMOTE_PACKAGE"
