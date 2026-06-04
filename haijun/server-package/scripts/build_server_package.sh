#!/usr/bin/env bash
set -euo pipefail

OUTPUT="${1:-server-package}"

cd "$(dirname "$0")/.."

bash scripts/validate_sync_package.sh .

mkdir -p "$OUTPUT"

items=(
  "configs"
  "data/curated"
  "data/eval"
  "datasets"
  "docs"
  "memory"
  "references"
  "remote"
  "scripts"
  "src"
  "pyproject.toml"
  "requirements-gpu.txt"
)

for item in "${items[@]}"; do
  if [[ ! -e "$item" ]]; then
    echo "missing package source: $item"
    exit 1
  fi
  rm -rf "$OUTPUT/$item"
  mkdir -p "$(dirname "$OUTPUT/$item")"
  cp -a "$item" "$OUTPUT/$item"
done

cp -f docs/SERVER_PACKAGE_README.md "$OUTPUT/README.md"

if find "$OUTPUT" \( -name '*.gguf' -o -name '*.safetensors' -o -name '*.bin' -o -name '*.pt' -o -name '*.pth' -o -name '*.onnx' -o -name '*.zip' -o -name '*.rar' -o -name '*.7z' -o -name '*.tar' -o -name '*.gz' -o -name '*.xz' -o -name '.env' -o -name '.env.*' \) -print -quit | grep -q .; then
  echo "server package contains forbidden artifacts"
  find "$OUTPUT" \( -name '*.gguf' -o -name '*.safetensors' -o -name '*.bin' -o -name '*.pt' -o -name '*.pth' -o -name '*.onnx' -o -name '*.zip' -o -name '*.rar' -o -name '*.7z' -o -name '*.tar' -o -name '*.gz' -o -name '*.xz' -o -name '.env' -o -name '.env.*' \) -print
  exit 1
fi

echo "OK: server package built at $PWD/$OUTPUT"

