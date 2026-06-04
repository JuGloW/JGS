#!/usr/bin/env bash
set -euo pipefail

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
  "remote/server/first_run_server.sh"
  "remote/server/inspect_server.sh"
  "remote/server/bootstrap_server_cpu.sh"
  "scripts/inspect_gpu_server.sh"
  "scripts/Inspect-GpuServer.ps1"
  "datasets/haijun_sft.jsonl"
  "data/eval/haijun_eval_v0_1.jsonl"
)

for path in "${required[@]}"; do
  if [[ ! -e "$path" ]]; then
    echo "missing: $path"
    exit 1
  fi
done

for pattern in "*.gguf" "*.safetensors" "*.bin" "*.pt" "*.pth" "*.onnx" "*.zip" "*.rar" "*.7z" "*.tar" "*.gz" "*.xz"; do
  if find . -name "$pattern" -print -quit | grep -q .; then
    echo "forbidden artifact found: $pattern"
    find . -name "$pattern" -print
    exit 1
  fi
done

if find . -name ".env" -o -name ".env.*" | grep -q .; then
  echo "forbidden env file found"
  find . -name ".env" -o -name ".env.*"
  exit 1
fi

echo "OK: Haijun server package structure is valid."
