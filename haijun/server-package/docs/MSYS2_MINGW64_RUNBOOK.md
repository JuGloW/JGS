# MSYS2 MINGW64 Runbook

This project treats MSYS2 MINGW64 as the main Linux-style terminal on the local
Windows control computer. Use it for commands that will later connect to the
Linux GPU server through `ssh`, `scp`, and shell scripts.

## Local Project Path

In MSYS2 MINGW64, the local Haijun workspace is:

```bash
cd "/d/github AI/haijun-ai"
```

The local mock server path is:

```bash
"/d/GPU-server/haijun-ai/server-package"
```

The real GPU server path remains:

```bash
~/haijun-ai/server-package
```

## Tool Check

Run this before first server work:

```bash
cd "/d/github AI/haijun-ai"
bash scripts/check_msys2_toolchain.sh
```

If `ssh` or `scp` is missing inside MSYS2, install or enable the MSYS2 OpenSSH
package before uploading to the GPU server. Do not use WSL as the default path
for Haijun server control.

## Package Build

```bash
cd "/d/github AI/haijun-ai"
bash scripts/validate_sync_package.sh .
bash scripts/build_server_package.sh server-package
bash scripts/pack_server_package.sh server-package dist/haijun-server-package.tar.gz
```

This only validates and packages files. It does not download models, install
GPU runtimes, or start training.

## Local Mock Test

```bash
cd "/d/github AI/haijun-ai"
bash scripts/stage_local_gpu_server_mock.sh server-package /d/GPU-server haijun-ai/server-package
bash scripts/test_local_gpu_server_mock.sh "/d/GPU-server/haijun-ai/server-package"
```

This simulates `~/haijun-ai/server-package` without renting a server.

## Upload When Server Exists

```bash
cd "/d/github AI/haijun-ai"
bash scripts/upload_server_package.sh haijun-gpu
```

The upload script creates `~/haijun-ai` on the server, uploads the package, and
prints the next validation commands. GPU activation is still separate and must
wait until model choice, budget, dataset, and eval are ready.
