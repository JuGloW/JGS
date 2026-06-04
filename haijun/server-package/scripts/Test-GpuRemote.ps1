param(
  [string]$HostAlias = "haijun-gpu",
  [string]$RemoteRoot = "~/haijun-ai/server-package"
)

$ErrorActionPreference = "Stop"

Write-Host "Testing SSH control path for $HostAlias"
ssh $HostAlias "hostname && date -u && uptime"

Write-Host "Checking remote GPU"
ssh $HostAlias "command -v nvidia-smi >/dev/null 2>&1 && nvidia-smi || echo 'nvidia-smi not available'"

Write-Host "Checking remote disk"
ssh $HostAlias "df -h ~"

Write-Host "Checking remote workspace path"
ssh $HostAlias "mkdir -p $RemoteRoot && test -d $RemoteRoot && echo ready:$RemoteRoot"

Write-Host "Remote control path OK"
Write-Host "If the server package is already uploaded, run:"
Write-Host "  powershell -ExecutionPolicy Bypass -File scripts\Inspect-GpuServer.ps1 -HostAlias $HostAlias -RemotePackageRoot $RemoteRoot"
