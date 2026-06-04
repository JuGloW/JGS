#!/usr/bin/env bash
set -euo pipefail

CONFIG="${1:-configs/haijun.yaml}"
MODEL_ID="${MODEL_ID:-}"

if [[ -z "$MODEL_ID" ]]; then
  echo "Set MODEL_ID before running, for example:"
  echo "MODEL_ID=your/base-model bash remote/gpu/run_training.sh $CONFIG"
  exit 2
fi

source .venv/bin/activate
python scripts/validate_dataset.py datasets/haijun_sft.jsonl
python scripts/train_lora.py --config "$CONFIG" --model-id "$MODEL_ID"

