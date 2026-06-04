# Local GPU Server Mock Test

This test simulates the future server layout without renting or activating a GPU.

Local mock path:

```text
D:\GPU-server\haijun-ai\server-package
```

This stands in for:

```text
~/haijun-ai/server-package
```

## Stage The Mock Server Package

Windows PowerShell:

```powershell
cd "D:\github AI\haijun-ai"
powershell -ExecutionPolicy Bypass -File scripts\Stage-LocalGpuServerMock.ps1
```

MSYS2 MINGW64:

```bash
cd "/d/github AI/haijun-ai"
bash scripts/stage_local_gpu_server_mock.sh server-package /d/GPU-server haijun-ai/server-package
```

## Test From Mock Path

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\Test-LocalGpuServerMock.ps1
```

MSYS2 MINGW64:

```bash
bash scripts/test_local_gpu_server_mock.sh "/d/GPU-server/haijun-ai/server-package"
```

The test checks:

- OS;
- disk;
- Python availability;
- GPU presence;
- `nvidia-smi` if available;
- required package structure;
- forbidden artifacts;
- dataset validation;
- eval validation.

The real server equivalent is:

```bash
cd ~/haijun-ai/server-package
bash remote/server/inspect_server.sh
```

The local mock is only a layout simulation before renting a GPU server.

The mock PowerShell test also writes local mock reports to:

```text
D:\GPU-server\haijun-ai\server-package\runs\server-inspection\
```

Those files are useful only for checking the package/test flow before renting a
server. The real server will generate its own reports under
`~/haijun-ai/server-package/runs/server-inspection/`.

## Not Tested

This does not:

- install GPU dependencies;
- download models;
- run training;
- install portable AI;
- activate or require a GPU.

## Success Meaning

If this mock passes, the package layout and validation flow are ready. When a
real server is rented, copy the same server package to:

```text
~/haijun-ai/server-package
```
