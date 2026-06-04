# GPU Runbook

## Local Preparation

```powershell
cd "D:\github AI\haijun-ai"
powershell -ExecutionPolicy Bypass -File scripts\Prepare-Dataset.ps1
powershell -ExecutionPolicy Bypass -File scripts\Validate-Dataset.ps1 datasets\haijun_sft.jsonl
powershell -ExecutionPolicy Bypass -File scripts\Validate-Eval.ps1 data\eval\haijun_eval_v0_1.jsonl
powershell -ExecutionPolicy Bypass -File scripts\Validate-SyncPackage.ps1
powershell -ExecutionPolicy Bypass -File scripts\Pack-ServerPackage.ps1
```

Do not install the GPU Python stack on the local computer. Local preparation is
limited to dataset and configuration checks.

## Sync to GPU

Edit `configs/haijun.yaml` and fill:

- `remote.host`
- `remote.user`
- `remote.port`
- `remote.remote_root`

Then run:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\sync_to_gpu.ps1
```

The sync script validates the package first and excludes local model weights,
archives, raw data, runs, adapters, and secrets.

Alternative for first setup: upload the generated `server-package/` folder
directly to the server. This folder is built from a whitelist and is separate
from the full local workspace:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\Build-ServerPackage.ps1
```

MSYS2 MINGW64:

```bash
cd "/d/github AI/haijun-ai"
bash scripts/build_server_package.sh
bash scripts/pack_server_package.sh
```

Recommended server path:

```text
~/haijun-ai/server-package/
```

First install checklist:

- `docs/SERVER_FIRST_INSTALL_CHECKLIST.md`

## On GPU Server

First inspect the real server system from inside the uploaded package:

```bash
cd ~/haijun-ai/server-package
bash remote/server/inspect_server.sh
```

Or from the local control terminal through SSH:

```bash
bash scripts/inspect_gpu_server.sh haijun-gpu
```

Only continue to GPU setup after the server inspection and package validation
look correct.

```bash
cd ~/haijun-ai/server-package
bash remote/gpu/setup_gpu.sh
MODEL_ID=your/base-model bash remote/gpu/run_training.sh configs/haijun.yaml
```

Model downloads happen on the server only. The local model registry is metadata,
not a local download queue.

After training, download only:

- adapter directory;
- metrics;
- evaluation report;
- training config copy.

Then stop the GPU server.

## GPU Cost Rule

- Start the GPU only when dataset, model choice, SSH, DNS, and run config are ready.
- Keep early tests short.
- Stop the GPU after the run finishes, fails clearly, or reaches the planned time cap.
- Analyze results locally before renting another run.
