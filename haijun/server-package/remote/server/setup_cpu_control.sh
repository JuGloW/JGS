#!/usr/bin/env bash
set -euo pipefail

python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install pyyaml

python scripts/validate_dataset.py datasets/haijun_sft.jsonl

echo "OK: CPU-only control environment is ready. No model was downloaded."

