#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
MAX_MB="${MAX_FILE_SIZE_MB:-5}"
MAX_BYTES=$((MAX_MB * 1024 * 1024))

cd "$(dirname "$0")/.."
ROOT="$(cd "$ROOT" && pwd)"

forbidden_ext_regex='\.(gguf|safetensors|bin|pt|pth|onnx|zip|rar|7z|tar|gz|xz)$'
excluded_path_regex='/(.venv|models|adapters|runs|data/raw|server-package|dist)(/|$)'

problems=()

while IFS= read -r -d '' file; do
  rel="${file#$ROOT/}"
  unix_path="/${rel//\\//}"

  if [[ "$unix_path" =~ $excluded_path_regex ]]; then
    continue
  fi

  name="$(basename "$file")"
  if [[ "$name" == ".env" || "$name" == .env.* ]]; then
    problems+=("forbidden env file: $rel")
  fi

  lower="$(printf '%s' "$file" | tr '[:upper:]' '[:lower:]')"
  if [[ "$lower" =~ $forbidden_ext_regex ]]; then
    problems+=("forbidden extension: $rel")
  fi

  size=0
  if command -v stat >/dev/null 2>&1; then
    size="$(stat -c%s "$file" 2>/dev/null || stat -f%z "$file" 2>/dev/null || echo 0)"
  fi
  if [[ "$size" -gt "$MAX_BYTES" ]]; then
    case "$rel" in
      references/copied-key-files/haicode_data_instruction_set.txt|references/copied-key-files/syscalls.master|references/portable-ai/PortableLM_chat_server.py)
        ;;
      *)
        problems+=("file exceeds ${MAX_MB}MB: $rel ($size bytes)")
        ;;
    esac
  fi

  case "$lower" in
    *.txt|*.md|*.yaml|*.yml|*.json|*.jsonl|*.py|*.ps1|*.sh|*.bat|*.cmd|*.toml|*.h|*.in)
      if [[ "$rel" != "scripts/Validate-SyncPackage.ps1" && "$rel" != "scripts/validate_sync_package.sh" ]]; then
        if grep -Eq -- '-----BEGIN (OPENSSH |RSA )?PRIVATE KEY-----|hf_[A-Za-z0-9]{20,}|ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9]{20,}' "$file" 2>/dev/null; then
          problems+=("possible secret pattern: $rel")
        fi
      fi
      ;;
  esac
done < <(find "$ROOT" -type f -print0)

if [[ "${#problems[@]}" -gt 0 ]]; then
  echo "Sync package validation failed:"
  printf ' - %s\n' "${problems[@]}"
  exit 1
fi

count="$(find "$ROOT" -type f | wc -l | tr -d ' ')"
echo "OK: sync package validation passed."
echo "Checked $count files under $ROOT"

