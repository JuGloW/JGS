#!/usr/bin/env bash
set -euo pipefail

REPORT_DIR="${HAIJUN_INSPECTION_DIR:-runs/server-inspection}"
mkdir -p "$REPORT_DIR"

TS="$(date -u '+%Y%m%dT%H%M%SZ' 2>/dev/null || date '+%Y%m%dT%H%M%S')"
REPORT_TXT="$REPORT_DIR/inspection-$TS.txt"
FACTS_JSONL="$REPORT_DIR/inspection-$TS.facts.jsonl"

json_escape() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g; s/	/\\t/g'
}

fact() {
  local key="$1"
  local value="${2:-}"
  printf '{"key":"%s","value":"%s"}\n' "$(json_escape "$key")" "$(json_escape "$value")" >> "$FACTS_JSONL"
}

section() {
  echo
  echo "== $1 =="
}

run_show() {
  local label="$1"
  shift
  echo "-- $label"
  "$@" 2>&1 || echo "not available"
}

exec > >(tee "$REPORT_TXT") 2>&1

echo "== Haijun real server inspection =="
echo "time_utc: $TS"
echo "cwd: $(pwd)"
echo "report_txt: $REPORT_TXT"
echo "facts_jsonl: $FACTS_JSONL"
fact "time_utc" "$TS"
fact "cwd" "$(pwd)"
fact "report_txt" "$REPORT_TXT"
fact "facts_jsonl" "$FACTS_JSONL"

section "OS"
KERNEL="$(uname -a 2>/dev/null || echo unknown)"
echo "kernel: $KERNEL"
fact "kernel" "$KERNEL"

if [[ -f /etc/os-release ]]; then
  OS_PRETTY="$(grep '^PRETTY_NAME=' /etc/os-release | head -1 | cut -d= -f2- | tr -d '"' || true)"
  OS_ID="$(grep '^ID=' /etc/os-release | head -1 | cut -d= -f2- | tr -d '"' || true)"
  OS_VERSION="$(grep '^VERSION_ID=' /etc/os-release | head -1 | cut -d= -f2- | tr -d '"' || true)"
  echo "os_pretty: ${OS_PRETTY:-unknown}"
  echo "os_id: ${OS_ID:-unknown}"
  echo "os_version: ${OS_VERSION:-unknown}"
  fact "os_pretty" "${OS_PRETTY:-unknown}"
  fact "os_id" "${OS_ID:-unknown}"
  fact "os_version" "${OS_VERSION:-unknown}"
  echo "-- /etc/os-release"
  cat /etc/os-release
else
  echo "/etc/os-release not found"
  fact "os_pretty" "unknown"
fi

section "User"
USER_NAME="$(id -un 2>/dev/null || whoami 2>/dev/null || echo unknown)"
USER_ID="$(id 2>/dev/null || echo unknown)"
echo "user: $USER_NAME"
echo "id: $USER_ID"
echo "shell: ${SHELL:-unknown}"
echo "home: ${HOME:-unknown}"
fact "user" "$USER_NAME"
fact "id" "$USER_ID"
fact "shell" "${SHELL:-unknown}"
fact "home" "${HOME:-unknown}"

section "CPU and Memory"
CPU_SUMMARY="$(command -v lscpu >/dev/null 2>&1 && lscpu | grep -E 'Model name|CPU\\(s\\)|Architecture' | head -12 || grep -E 'model name|cpu cores|processor' /proc/cpuinfo 2>/dev/null | head -12 || echo unknown)"
echo "$CPU_SUMMARY"
fact "cpu_summary" "$CPU_SUMMARY"
if command -v free >/dev/null 2>&1; then
  free -h
  MEM_TOTAL="$(free -h | awk '/^Mem:/ {print $2}')"
  MEM_AVAILABLE="$(free -h | awk '/^Mem:/ {print $7}')"
  fact "memory_total" "${MEM_TOTAL:-unknown}"
  fact "memory_available" "${MEM_AVAILABLE:-unknown}"
elif [[ -f /proc/meminfo ]]; then
  grep -E 'MemTotal|MemAvailable|SwapTotal|SwapFree' /proc/meminfo
  fact "memory_total" "$(awk '/MemTotal/ {print $2 " " $3}' /proc/meminfo)"
  fact "memory_available" "$(awk '/MemAvailable/ {print $2 " " $3}' /proc/meminfo)"
else
  echo "memory info not available"
  fact "memory_total" "unknown"
fi

section "Disk"
run_show "current package path disk" df -h .
DISK_AVAIL="$(df -h . 2>/dev/null | awk 'NR==2 {print $4}')"
DISK_USED="$(df -h . 2>/dev/null | awk 'NR==2 {print $3}')"
DISK_MOUNT="$(df -h . 2>/dev/null | awk 'NR==2 {print $6}')"
fact "disk_used_current_path" "${DISK_USED:-unknown}"
fact "disk_available_current_path" "${DISK_AVAIL:-unknown}"
fact "disk_mount_current_path" "${DISK_MOUNT:-unknown}"
if [[ -n "${HOME:-}" ]]; then
  run_show "home disk" df -h "$HOME"
fi
if command -v findmnt >/dev/null 2>&1; then
  run_show "mount for current path" findmnt -T .
else
  run_show "mount sample" sh -c "mount | head -40"
fi

section "Python"
if command -v python3 >/dev/null 2>&1; then
  PYTHON_VERSION="$(python3 --version 2>&1)"
  PYTHON_PATH="$(command -v python3)"
  echo "python3: $PYTHON_VERSION"
  echo "python3_path: $PYTHON_PATH"
  fact "python3_status" "found"
  fact "python3_version" "$PYTHON_VERSION"
  fact "python3_path" "$PYTHON_PATH"
else
  echo "python3 not found"
  fact "python3_status" "missing"
fi

section "Package Managers"
for tool in apt apt-get dnf yum pacman zypper apk conda mamba uv pip3; do
  if command -v "$tool" >/dev/null 2>&1; then
    TOOL_PATH="$(command -v "$tool")"
    echo "found: $tool -> $TOOL_PATH"
    fact "tool_$tool" "$TOOL_PATH"
  else
    echo "missing: $tool"
    fact "tool_$tool" "missing"
  fi
done

section "GPU"
GPU_STATUS="unknown"
if command -v nvidia-smi >/dev/null 2>&1; then
  echo "-- nvidia-smi"
  if nvidia-smi; then
    GPU_STATUS="nvidia-smi-ok"
  else
    GPU_STATUS="nvidia-smi-command-failed"
  fi
else
  echo "nvidia-smi not found; OK before GPU runtime setup."
  GPU_STATUS="nvidia-smi-missing"
fi
fact "gpu_nvidia_smi_status" "$GPU_STATUS"

if command -v rocm-smi >/dev/null 2>&1; then
  echo "-- rocm-smi"
  rocm-smi || true
  fact "gpu_rocm_smi_status" "found"
else
  echo "rocm-smi not found"
  fact "gpu_rocm_smi_status" "missing"
fi

if command -v lspci >/dev/null 2>&1; then
  GPU_LSPCI="$(lspci | grep -Ei 'nvidia|amd|radeon|gpu|vga|3d controller' || true)"
  if [[ -n "$GPU_LSPCI" ]]; then
    echo "-- lspci gpu entries"
    echo "$GPU_LSPCI"
    fact "gpu_lspci_entries" "$GPU_LSPCI"
  else
    echo "no GPU entry found by lspci"
    fact "gpu_lspci_entries" "none"
  fi
else
  echo "lspci not found"
  fact "gpu_lspci_entries" "lspci-missing"
fi

section "CUDA"
for path in /usr/local/cuda /usr/local/cuda/bin/nvcc; do
  if [[ -e "$path" ]]; then
    echo "found: $path"
    fact "cuda_path_$path" "found"
  else
    echo "missing: $path"
    fact "cuda_path_$path" "missing"
  fi
done
if command -v nvcc >/dev/null 2>&1; then
  NVCC_VERSION="$(nvcc --version 2>&1 | tail -5)"
  echo "$NVCC_VERSION"
  fact "nvcc_status" "found"
  fact "nvcc_version" "$NVCC_VERSION"
else
  echo "nvcc not found"
  fact "nvcc_status" "missing"
fi

section "Network"
HOSTNAME_VALUE="$(hostname 2>/dev/null || echo unknown)"
echo "hostname: $HOSTNAME_VALUE"
fact "hostname" "$HOSTNAME_VALUE"
if command -v ip >/dev/null 2>&1; then
  ip -brief addr || true
elif command -v hostname >/dev/null 2>&1; then
  hostname -I || true
fi

section "Haijun Package"
PACKAGE_STATUS="missing-validator"
if [[ -f remote/server/validate_server_package.sh ]]; then
  if bash remote/server/validate_server_package.sh; then
    PACKAGE_STATUS="valid"
  else
    PACKAGE_STATUS="invalid"
  fi
else
  echo "remote/server/validate_server_package.sh not found in cwd."
fi
fact "package_validation" "$PACKAGE_STATUS"

section "Dataset and Eval"
if [[ -f datasets/haijun_sft.jsonl ]]; then
  DATASET_LINES="$(wc -l < datasets/haijun_sft.jsonl | tr -d ' ')"
  echo "dataset_path: datasets/haijun_sft.jsonl"
  echo "dataset_lines: $DATASET_LINES"
  fact "dataset_path" "datasets/haijun_sft.jsonl"
  fact "dataset_lines" "$DATASET_LINES"
else
  echo "dataset file not found"
  fact "dataset_path" "missing"
fi

if [[ -f data/eval/haijun_eval_v0_1.jsonl ]]; then
  EVAL_LINES="$(wc -l < data/eval/haijun_eval_v0_1.jsonl | tr -d ' ')"
  echo "eval_path: data/eval/haijun_eval_v0_1.jsonl"
  echo "eval_lines: $EVAL_LINES"
  fact "eval_path" "data/eval/haijun_eval_v0_1.jsonl"
  fact "eval_lines" "$EVAL_LINES"
else
  echo "eval file not found"
  fact "eval_path" "missing"
fi

DATASET_VALIDATION="skipped"
if command -v python3 >/dev/null 2>&1 && [[ -f scripts/validate_dataset.py && -f datasets/haijun_sft.jsonl ]]; then
  if python3 scripts/validate_dataset.py datasets/haijun_sft.jsonl; then
    DATASET_VALIDATION="valid"
  else
    DATASET_VALIDATION="invalid"
  fi
else
  echo "python dataset validation skipped"
fi
fact "dataset_validation" "$DATASET_VALIDATION"

section "Summary"
echo "package_validation: $PACKAGE_STATUS"
echo "python3_status: $(grep '\"key\":\"python3_status\"' "$FACTS_JSONL" | tail -1 | sed 's/.*\"value\":\"//; s/\"}$//')"
echo "gpu_nvidia_smi_status: $GPU_STATUS"
echo "dataset_validation: $DATASET_VALIDATION"
echo "report_txt: $REPORT_TXT"
echo "facts_jsonl: $FACTS_JSONL"
echo
echo "OK: inspection finished. No model download, install, training, or GPU job was started."
