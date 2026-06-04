# Server First Install Checklist

Use this checklist when the server is available. This phase does not download
models and does not require GPU training.

## Local Preparation

From the local control computer with Windows PowerShell:

```powershell
cd "D:\github AI\haijun-ai"
powershell -ExecutionPolicy Bypass -File scripts\Build-ServerPackage.ps1
powershell -ExecutionPolicy Bypass -File scripts\Pack-ServerPackage.ps1
```

From MSYS2 MINGW64, which is the preferred Windows-to-Linux control terminal
for Haijun:

```bash
cd "/d/github AI/haijun-ai"
bash scripts/build_server_package.sh
bash scripts/pack_server_package.sh
```

This creates:

```text
dist/haijun-server-package.zip
dist/haijun-server-package.tar.gz
```

Optional local mock test before renting a server:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\Stage-LocalGpuServerMock.ps1
powershell -ExecutionPolicy Bypass -File scripts\Test-LocalGpuServerMock.ps1
```

MSYS2 MINGW64 local mock test:

```bash
bash scripts/stage_local_gpu_server_mock.sh server-package /d/GPU-server haijun-ai/server-package
bash scripts/test_local_gpu_server_mock.sh "/d/GPU-server/haijun-ai/server-package"
```

## Server Preparation

On the server:

```bash
mkdir -p ~/haijun-ai
```

## Upload From Local

After SSH alias or host is ready:

```powershell
cd "D:\github AI\haijun-ai"
powershell -ExecutionPolicy Bypass -File scripts\Upload-ServerPackage.ps1 -HostAlias haijun-gpu
```

MSYS2 MINGW64 upload:

```bash
cd "/d/github AI/haijun-ai"
bash scripts/upload_server_package.sh haijun-gpu
```

Or with explicit host/user:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\Upload-ServerPackage.ps1 -HostAlias user@server-host
```

## Install On Server

On the server:

```bash
cd ~/haijun-ai
unzip -o haijun-server-package.zip -d server-package
cd ~/haijun-ai/server-package
bash remote/server/first_run_server.sh
```

If uploading the `.tar.gz` package:

```bash
cd ~/haijun-ai
rm -rf server-package
mkdir -p server-package
tar -xzf haijun-server-package.tar.gz -C server-package
cd ~/haijun-ai/server-package
bash remote/server/first_run_server.sh
```

Or inspect from the local control terminal after upload:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\Inspect-GpuServer.ps1 -HostAlias haijun-gpu
```

From MSYS2 MINGW64:

```bash
cd "/d/github AI/haijun-ai"
bash scripts/inspect_gpu_server.sh haijun-gpu
```

## CPU-Only Setup

If the bootstrap check passes and Python is available:

```bash
cd ~/haijun-ai/server-package
bash remote/server/setup_cpu_control.sh
```

## Do Not Do Yet

- Do not download model weights.
- Do not start training.
- Do not run GPU jobs.
- Do not install portable AI runtime.
- Do not keep GPU active while only preparing files.

## Ready For Next Phase When

- SSH works.
- DNS/host is stable.
- `~/haijun-ai/server-package` exists.
- package validation passes.
- dataset validation passes.
- eval validation passes.
- disk is enough for selected future model.
- model choice and budget are written down.
