# Server Rental Ready Checklist

Use this before spending GPU budget. The goal is to avoid renting a GPU before
the package, SSH, and inspection flow are ready.

## Before Renting

- `D:\github AI\haijun-ai\server-package` is rebuilt.
- `dist\haijun-server-package.zip` is rebuilt.
- Local mock at `D:\GPU-server\haijun-ai\server-package` passes.
- SSH alias or `user@host` target is known.
- Private SSH key is outside the repository.
- No model weights are stored locally.
- No `.env`, tokens, passwords, or SSH keys are inside the package.

## Recommended Server Baseline

- Linux server with SSH access.
- Enough disk for future model cache and training runs.
- Python 3 available, or installable after approval.
- NVIDIA GPU preferred for first training phase.
- `nvidia-smi` available when GPU runtime is ready.
- Stable hostname or provider IP for the rental session.

## First Command On Server

After upload and extraction:

```bash
cd ~/haijun-ai/server-package
bash remote/server/first_run_server.sh
```

This checks:

- OS and kernel;
- disk;
- Python;
- GPU presence hints;
- `nvidia-smi` only if available;
- package structure;
- forbidden artifacts;
- dataset;
- eval.

It writes:

```text
runs/server-inspection/inspection-<UTC>.txt
runs/server-inspection/inspection-<UTC>.facts.jsonl
runs/server-inspection/first-run-decision-<UTC>.md
```

## Do Not Do During First Run

- Do not install GPU dependencies.
- Do not download model weights.
- Do not run training.
- Do not start long jobs.
- Do not keep the GPU active while only preparing files.

## Decision Rules

- `cpu-control-ready`: package, Python, dataset, and eval look ready. CPU-only
  setup may continue after review.
- `package-ready-python-missing`: package and data are valid, but Python needs
  installation after approval.
- `not-ready`: fix package, dataset, or eval before using GPU budget.

GPU setup is only allowed after the first-run report is reviewed and the owner
explicitly approves model choice, budget, and time cap.
