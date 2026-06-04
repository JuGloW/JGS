param(
  [string]$HostAlias = "haijun-gpu",
  [string]$RemotePackageRoot = "~/haijun-ai/server-package",
  [int]$Port = 22
)

$ErrorActionPreference = "Stop"

Write-Host "Inspecting remote server through SSH:"
Write-Host "  host: $HostAlias"
Write-Host "  remote_package_root: $RemotePackageRoot"
Write-Host "  port: $Port"
Write-Host ""

ssh -p $Port $HostAlias "cd $RemotePackageRoot && bash remote/server/inspect_server.sh"
