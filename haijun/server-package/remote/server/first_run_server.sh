#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="${HAIJUN_INSPECTION_DIR:-runs/server-inspection}"
mkdir -p "$REPORT_DIR"

TS="$(date -u '+%Y%m%dT%H%M%SZ' 2>/dev/null || date '+%Y%m%dT%H%M%S')"
DECISION_MD="$REPORT_DIR/first-run-decision-$TS.md"

echo "== Haijun first server run =="
echo "cwd: $(pwd)"
echo "decision_report: $DECISION_MD"
echo
echo "This first run only validates and inspects the server."
echo "It does not install packages, download models, start training, or activate GPU jobs."
echo

echo "== Step 1: package validation =="
PACKAGE_STATUS="invalid"
if bash remote/server/validate_server_package.sh; then
  PACKAGE_STATUS="valid"
fi
echo

echo "== Step 2: server inspection =="
bash remote/server/inspect_server.sh
echo

LATEST_FACTS="$(ls -1t "$REPORT_DIR"/inspection-*.facts.jsonl 2>/dev/null | head -1 || true)"
if [[ -z "$LATEST_FACTS" ]]; then
  echo "No inspection facts file found."
  exit 1
fi

fact_value() {
  local key="$1"
  awk -v wanted="\"key\":\"$key\"" '
    index($0, wanted) {
      sub(/^.*"value":"/, "", $0)
      sub(/"}$/, "", $0)
      value=$0
    }
    END { print value }
  ' "$LATEST_FACTS"
}

OS_PRETTY="$(fact_value os_pretty)"
KERNEL="$(fact_value kernel)"
DISK_AVAILABLE="$(fact_value disk_available_current_path)"
PYTHON_STATUS="$(fact_value python3_status)"
GPU_STATUS="$(fact_value gpu_nvidia_smi_status)"
PACKAGE_VALIDATION="$(fact_value package_validation)"
DATASET_VALIDATION="$(fact_value dataset_validation)"
DATASET_LINES="$(fact_value dataset_lines)"
EVAL_LINES="$(fact_value eval_lines)"
NVCC_STATUS="$(fact_value nvcc_status)"

SERVER_READY="needs-review"
NEXT_ACTION="Review the inspection report before installing anything."

if [[ "$PACKAGE_STATUS" == "valid" && "$PACKAGE_VALIDATION" == "valid" && "$DATASET_VALIDATION" == "valid" && "$PYTHON_STATUS" == "found" ]]; then
  SERVER_READY="cpu-control-ready"
  NEXT_ACTION="CPU-only setup may be allowed. GPU setup still waits for model choice, budget, and explicit approval."
elif [[ "$PACKAGE_STATUS" == "valid" && "$PACKAGE_VALIDATION" == "valid" && "$DATASET_VALIDATION" == "valid" ]]; then
  SERVER_READY="package-ready-python-missing"
  NEXT_ACTION="Package is valid, but python3 is missing. Install python3 only after owner approval."
else
  SERVER_READY="not-ready"
  NEXT_ACTION="Fix package, dataset, or eval validation before renting GPU time."
fi

cat > "$DECISION_MD" <<EOF
# Haijun First Run Decision

Time UTC: $TS

## Status

- server_ready: $SERVER_READY
- package_status: $PACKAGE_STATUS
- package_validation: ${PACKAGE_VALIDATION:-unknown}
- dataset_validation: ${DATASET_VALIDATION:-unknown}
- python3_status: ${PYTHON_STATUS:-unknown}
- gpu_nvidia_smi_status: ${GPU_STATUS:-unknown}
- nvcc_status: ${NVCC_STATUS:-unknown}

## Server Facts

- os: ${OS_PRETTY:-unknown}
- kernel: ${KERNEL:-unknown}
- disk_available_current_path: ${DISK_AVAILABLE:-unknown}
- dataset_lines: ${DATASET_LINES:-unknown}
- eval_lines: ${EVAL_LINES:-unknown}

## Decision

$NEXT_ACTION

## Important Rule

This first run did not install packages, download model weights, start training,
or activate GPU jobs.

## Reports

- facts_jsonl: $LATEST_FACTS
- decision_report: $DECISION_MD
EOF

echo "== Step 3: decision =="
cat "$DECISION_MD"
echo
echo "OK: first server run completed without install/download/training."
