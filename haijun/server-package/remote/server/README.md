# Server Setup Scripts

These scripts are intended to run on the remote server before or during GPU use.

## CPU-Only Phase

- `first_run_server.sh` is the first command to run after upload. It validates
  the package, inspects the real server, and writes a decision report without
  installing or downloading anything.
- `validate_server_package.sh` checks that the package structure exists and no
  local model weights are present.
- `inspect_server.sh` reads the real server OS, disk, Python, GPU/NVIDIA hints,
  dataset, and eval status, then writes reports under `runs/server-inspection/`.
- `setup_cpu_control.sh` creates a Python environment for lightweight control
  checks. It does not download models.

## GPU Phase

Use `remote/gpu/setup_gpu.sh` and `remote/gpu/run_training.sh` only when GPU
training or evaluation is ready.
