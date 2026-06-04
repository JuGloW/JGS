# RunPod Deploy Prep

Date: 2026-06-05

This document prepares the first Haijun RunPod deploy without spending GPU time
until the owner is ready to click Deploy.

## Current RunPod Choice

- Path: Pods
- Template: Runpod Pytorch 2.8.0
- Image: `runpod/pytorch:1.0.2-cu1281-torch280-ubuntu2404`
- GPU: RTX A5000
- GPU count: 1
- Pricing: On-Demand
- GPU price shown: `$0.27/hr`
- Container disk: 30 GB
- Persistent storage: 50 GB
- Persistent path on RunPod: `/workspace`
- Jupyter: optional/off for first run
- SSH terminal access: required
- Volume encryption: off for first run

## SSH Key

The RunPod public key was generated from MSYS2 MINGW64:

```text
~/.ssh/haijun_runpod.pub
```

Private key:

```text
~/.ssh/haijun_runpod
```

Never paste or upload the private key. Only paste the `.pub` line into RunPod.

## Before Clicking Deploy

- Confirm GPU is `RTX A5000`.
- Confirm GPU count is `1`.
- Confirm pricing is `On-Demand`, not Reserved.
- Confirm SSH terminal access no longer says `SSH key not configured`.
- Keep container disk at 30 GB.
- Keep persistent storage at 50 GB for first-run only.
- Do not enable expensive GPU choices.

## After Pod Is Running

RunPod will show a connection command. It may look like:

```bash
ssh root@<host> -p <port>
```

From MSYS2 MINGW64, upload and run first-run:

```bash
cd "/d/github AI/haijun-ai"
bash scripts/upload_runpod_package.sh <host> <port> root ~/.ssh/haijun_runpod
```

PowerShell alternative:

```powershell
cd "D:\github AI\haijun-ai"
powershell -ExecutionPolicy Bypass -File scripts\Upload-RunPodPackage.ps1 -HostName <host> -Port <port>
```

The script uploads:

```text
dist/haijun-server-package.zip
```

to:

```text
/workspace/haijun-ai/haijun-server-package.zip
```

Then extracts to:

```text
/workspace/haijun-ai/server-package
```

Then runs:

```bash
bash remote/server/first_run_server.sh
```

## Cost Rule

For the first RunPod session:

- Do not download model weights.
- Do not install GPU training dependencies beyond what already exists in the template.
- Do not start training.
- Only run SSH preflight, upload, extract, and first-run inspection.
- After reports are saved, stop or terminate the pod according to the next plan.

If the pod will not be reused soon, terminate/delete it instead of leaving
persistent storage billing active.
