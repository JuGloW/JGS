#!/usr/bin/env bash
set -euo pipefail

SOURCE_PACKAGE="${1:-server-package}"
MOCK_ROOT="${2:-/mnt/d/GPU-server}"
MOCK_PACKAGE="${3:-haijun-ai/server-package}"

cd "$(dirname "$0")/.."

if [[ ! -d "$SOURCE_PACKAGE" ]]; then
  bash scripts/build_server_package.sh "$SOURCE_PACKAGE"
fi

if find "$SOURCE_PACKAGE" \( -name '*.gguf' -o -name '*.safetensors' -o -name '*.bin' -o -name '*.pt' -o -name '*.pth' -o -name '*.onnx' -o -name '*.zip' -o -name '*.rar' -o -name '*.7z' -o -name '*.tar' -o -name '*.gz' -o -name '*.xz' -o -name '.env' -o -name '.env.*' \) -print -quit | grep -q .; then
  echo "server-package contains forbidden artifacts"
  exit 1
fi

TARGET="$MOCK_ROOT/$MOCK_PACKAGE"
mkdir -p "$(dirname "$TARGET")"
rm -rf "$TARGET"
cp -a "$SOURCE_PACKAGE" "$TARGET"

echo "OK: staged local GPU server mock"
echo "Source: $PWD/$SOURCE_PACKAGE"
echo "Target: $TARGET"
echo "Use this as local stand-in for: ~/haijun-ai/server-package"

