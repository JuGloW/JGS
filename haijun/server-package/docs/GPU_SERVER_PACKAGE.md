# GPU Server Package

This document defines what may be synced from the local control computer to the
GPU server.

## Purpose

The GPU server receives only the files needed to run Haijun preparation,
training, evaluation, and reference lookup.

The local control computer does not install AI portable runtimes and does not
store model weights.

## Local Package Folder

Build output:

- `server-package/`

This is the folder to upload to the server when the server subscription is
ready. It is intentionally separate from the full local workspace.

Recommended server destination:

```text
~/haijun-ai/server-package/
```

Here, `~/haijun-ai` is the main server root and `server-package` is the active
package root. Run commands from inside `~/haijun-ai/server-package`.

Do not place scripts one level too high. `configs/`, `remote/`, `scripts/`,
`datasets/`, and `docs/` must be directly under `~/haijun-ai/server-package/`.

Build command:

```powershell
cd "D:\github AI\haijun-ai"
powershell -ExecutionPolicy Bypass -File scripts\Build-ServerPackage.ps1
```

## Allowed To Sync

- configs;
- curated datasets;
- eval suites;
- documentation;
- small reference files;
- memory examples and term seeds;
- scripts;
- source package;
- remote GPU setup scripts.

## Not Allowed To Sync From Local

- model weights;
- training checkpoints;
- adapters;
- raw private data;
- `.env` files;
- secrets;
- large archives;
- local virtual environments;
- portable AI installed runtimes.

## Manifest

The package policy is recorded in:

- `configs/gpu_sync_manifest.yaml`

Before syncing, run:

```powershell
cd "D:\github AI\haijun-ai"
powershell -ExecutionPolicy Bypass -File scripts\Validate-SyncPackage.ps1
```

## Server Install Rule

All heavyweight install work happens on the server:

- Python GPU environment;
- PyTorch/CUDA stack;
- bitsandbytes;
- model downloads;
- training checkpoints;
- optional portable AI runtime experiments.

## Stop Rule

The GPU must be shut down after training, eval, or smoke testing finishes.
Haijun analysis continues locally from reports and metadata.
