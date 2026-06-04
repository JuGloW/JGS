# Haijun Server Package

This is the deployable Haijun package for the future GPU server.

Recommended server layout:

```text
~/haijun-ai/
  server-package/     # active control/training package
  server-models/      # server-only model cache, created later
  server-runs/        # server-only run outputs, created later
  server-adapters/    # server-only adapters/checkpoints, created later
```

Upload this folder so the active package root becomes:

```text
~/haijun-ai/server-package/
```

Run commands from:

```bash
cd ~/haijun-ai/server-package
```

## Validate Without GPU

```bash
bash remote/server/first_run_server.sh
```

`first_run_server.sh` validates the package, reads the real Linux server system,
and writes a decision report. It does not install anything, download models,
start training, or assume the server uses Windows, PowerShell, MSYS2, or WSL.

## CPU-Only Setup

```bash
bash remote/server/setup_cpu_control.sh
```

This does not download model weights.

## GPU Phase

Start GPU only when model choice, dataset, eval, SSH/DNS, budget, and stop
condition are ready.

```bash
bash remote/gpu/setup_gpu.sh
MODEL_ID=your/base-model bash remote/gpu/run_training.sh configs/haijun.yaml
```

## Forbidden In This Package

- model weights;
- checkpoints;
- adapters;
- `.env` files;
- SSH keys;
- raw private data;
- large archives;
- local portable AI runtime installs.
