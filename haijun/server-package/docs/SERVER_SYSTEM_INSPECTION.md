# Server System Inspection

Haijun reads the GPU server system with:

```bash
cd ~/haijun-ai/server-package
bash remote/server/first_run_server.sh
```

The first-run script validates the package, runs the system inspection, and
writes a decision report. The inspection script is written for a general Linux
server. It checks:

- OS and kernel;
- user, shell, and home path;
- CPU and memory;
- disk and mount information;
- Python availability;
- package manager hints;
- NVIDIA, ROCm, `lspci`, CUDA, and `nvcc` hints;
- basic network identity;
- Haijun package structure;
- dataset and eval files.

It writes real inspection output to:

```text
runs/server-inspection/inspection-<UTC>.txt
runs/server-inspection/inspection-<UTC>.facts.jsonl
runs/server-inspection/first-run-decision-<UTC>.md
```

The `.txt` report is for human reading. The `.facts.jsonl` report stores key
facts such as OS, kernel, disk, Python, GPU/NVIDIA status, dataset line count,
eval line count, and validation status.

It does not:

- install packages;
- download models;
- start training;
- activate a GPU job;
- assume MSYS2, PowerShell, or Windows exists on the server.

From the local control computer, run the same server inspection through SSH:

```bash
cd "/d/github AI/haijun-ai"
bash scripts/inspect_gpu_server.sh haijun-gpu
```

PowerShell wrapper:

```powershell
cd "D:\github AI\haijun-ai"
powershell -ExecutionPolicy Bypass -File scripts\Inspect-GpuServer.ps1 -HostAlias haijun-gpu
```

Those wrappers only connect to the server. The actual system reading still
happens on the remote Linux server.
