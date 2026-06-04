# SSH and DNS Runbook

Haijun depends on stable control-plane communication between this computer and
the rented GPU server.

From this Windows computer, use MSYS2 MINGW64 as the preferred Linux-style
terminal for GPU server interaction. PowerShell scripts remain available for
local packaging checks, but `ssh`, `scp`, and remote Linux commands should be
tested from MSYS2 MINGW64 when preparing the real server workflow.

## SSH Goals

- key-based login only;
- no password login when the server provider allows disabling it;
- stable keepalive settings;
- simple reconnect behavior;
- clear remote directory layout;
- no local model transfer.

## Recommended SSH Config

Create or update the local SSH config outside this project:

```sshconfig
Host haijun-gpu
  HostName your.gpu.server.domain
  User your_server_user
  Port 22
  IdentityFile C:/Users/ACER/.ssh/haijun_gpu
  ServerAliveInterval 30
  ServerAliveCountMax 6
  TCPKeepAlive yes
```

Then `configs/haijun.yaml` can use:

```yaml
remote:
  host: "haijun-gpu"
  user: "your_server_user"
  port: 22
  remote_root: "~/haijun-ai/server-package"
  dns_name: "your.gpu.server.domain"
```

## DNS Stability

Use DNS when the GPU provider supports a stable hostname. If the server IP
changes each rental session, use a provider hostname or update a DNS record
before syncing.

## Before Sync Checklist

- SSH alias works.
- DNS or host IP is stable for this session.
- Dedicated key is used.
- `configs/haijun.yaml` has `remote.host`, `remote.user`, `remote.port`, and
  `remote.remote_root`.
- `scripts\Validate-SyncPackage.ps1` passes.
- No model weights are stored locally.
- GPU rental has not started yet unless a training/eval run is ready.

Minimum checks before training:

- `ssh haijun-gpu "hostname && uptime"`
- `ssh haijun-gpu "nvidia-smi"`
- `ssh haijun-gpu "df -h"`
- `ssh haijun-gpu "date -u"`

Or run the local control check from PowerShell:

```powershell
cd "D:\github AI\haijun-ai"
powershell -ExecutionPolicy Bypass -File scripts\Test-GpuRemote.ps1 -HostAlias haijun-gpu -RemoteRoot "~/haijun-ai/server-package"
```

MSYS2 MINGW64 direct checks:

```bash
ssh haijun-gpu "hostname && uptime"
ssh haijun-gpu "command -v nvidia-smi >/dev/null 2>&1 && nvidia-smi || echo nvidia-smi-not-available"
ssh haijun-gpu "df -h ~"
ssh haijun-gpu "date -u"
```

After `server-package` is uploaded, run the full server-side inspection:

```bash
cd "/d/github AI/haijun-ai"
bash scripts/inspect_gpu_server.sh haijun-gpu
```

This reads the remote Linux server system through `remote/server/inspect_server.sh`.
It does not inspect the local Windows/MSYS2 machine except as an SSH launcher.

## Security Notes

- Keep private SSH keys outside the repository.
- Never commit `.env`, keys, provider tokens, or server passwords.
- Prefer a dedicated key for Haijun GPU servers.
- Rotate the key if a rented server image or provider account is compromised.
