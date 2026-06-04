#!/usr/bin/env bash
set -euo pipefail

MOCK_PACKAGE_PATH="${1:-/mnt/d/GPU-server/haijun-ai/server-package}"

if [[ ! -d "$MOCK_PACKAGE_PATH" ]]; then
  echo "Mock package path not found: $MOCK_PACKAGE_PATH"
  exit 1
fi

cd "$MOCK_PACKAGE_PATH"

echo "== Haijun local GPU-server mock =="
echo "Mock path: $MOCK_PACKAGE_PATH"
echo "This simulates: ~/haijun-ai/server-package"
echo

echo "== OS =="
uname -a || true
if [[ -f /etc/os-release ]]; then
  cat /etc/os-release
fi
echo

echo "== Disk =="
df -h .
echo

echo "== Python =="
if command -v python3 >/dev/null 2>&1; then
  python3 --version
else
  echo "python3 not found; server will need python3 for CPU setup."
fi
echo

echo "== GPU presence =="
if command -v lspci >/dev/null 2>&1; then
  lspci | grep -Ei 'vga|3d|display|nvidia|amd|intel' || true
else
  echo "lspci not found; skipping generic GPU listing."
fi
echo

echo "== nvidia-smi =="
if command -v nvidia-smi >/dev/null 2>&1; then
  nvidia-smi || true
else
  echo "nvidia-smi not found; OK for CPU-only/mock preparation."
fi
echo

echo "== Package structure =="
required=(
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
  "requirements-gpu.txt"
)
for path in "${required[@]}"; do
  if [[ ! -e "$path" ]]; then
    echo "missing package path: $path"
    exit 1
  fi
done
echo "OK: required package paths exist."

echo "== Forbidden artifacts =="
if find . \( -name '*.gguf' -o -name '*.safetensors' -o -name '*.bin' -o -name '*.pt' -o -name '*.pth' -o -name '*.onnx' -o -name '*.zip' -o -name '*.rar' -o -name '*.7z' -o -name '*.tar' -o -name '*.gz' -o -name '*.xz' -o -name '.env' -o -name '.env.*' \) -print -quit | grep -q .; then
  find . \( -name '*.gguf' -o -name '*.safetensors' -o -name '*.bin' -o -name '*.pt' -o -name '*.pth' -o -name '*.onnx' -o -name '*.zip' -o -name '*.rar' -o -name '*.7z' -o -name '*.tar' -o -name '*.gz' -o -name '*.xz' -o -name '.env' -o -name '.env.*' \) -print
  echo "forbidden artifacts found in mock package"
  exit 1
fi
echo "OK: no model weights, archives, or env files found."

echo "== Dataset validation =="
if command -v python3 >/dev/null 2>&1; then
  python3 scripts/validate_dataset.py datasets/haijun_sft.jsonl
else
  echo "Skipping Python dataset validation because python3 is missing."
fi

echo "== Eval validation =="
test -f data/eval/haijun_eval_v0_1.jsonl
wc -l data/eval/haijun_eval_v0_1.jsonl

echo "== Summary =="
files="$(find . -type f | wc -l | tr -d ' ')"
bytes="$(find . -type f -printf '%s\n' 2>/dev/null | awk '{s+=$1} END {print s+0}' || echo unknown)"
echo "Files: $files"
echo "Bytes: $bytes"
echo "OK: local mock server package test completed. No install or model download was performed."

