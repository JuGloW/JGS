param(
  [Parameter(Mandatory=$true)]
  [string]$HostName,

  [Parameter(Mandatory=$true)]
  [int]$Port,

  [string]$User = "root",
  [string]$SshKey = "$env:USERPROFILE\.ssh\haijun_runpod",
  [string]$PackageZip = "dist\haijun-server-package.zip"
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $PSScriptRoot)

$remoteRoot = "/workspace/haijun-ai"
$remotePackage = "$remoteRoot/server-package"

if (-not (Test-Path -LiteralPath $SshKey)) {
  throw "missing SSH key: $SshKey"
}

if (-not (Test-Path -LiteralPath $PackageZip)) {
  throw "missing package zip: $PackageZip"
}

Write-Host "== Haijun RunPod upload =="
Write-Host "host: $HostName"
Write-Host "port: $Port"
Write-Host "user: $User"
Write-Host "ssh_key: $SshKey"
Write-Host "package_zip: $PackageZip"
Write-Host "remote_package: $remotePackage"
Write-Host ""

Write-Host "== SSH preflight =="
ssh -i $SshKey -p $Port -o StrictHostKeyChecking=accept-new -o ServerAliveInterval=30 "$User@$HostName" "hostname && pwd && mkdir -p '$remoteRoot'"

Write-Host "== Upload package =="
scp -i $SshKey -P $Port -o StrictHostKeyChecking=accept-new $PackageZip "$User@$HostName`:$remoteRoot/haijun-server-package.zip"

Write-Host "== Extract and first-run =="
ssh -i $SshKey -p $Port -o StrictHostKeyChecking=accept-new -o ServerAliveInterval=30 "$User@$HostName" "cd '$remoteRoot' && rm -rf server-package && mkdir -p server-package && python3 -m zipfile -e haijun-server-package.zip server-package && cd server-package && bash remote/server/first_run_server.sh"

Write-Host "OK: RunPod upload and first-run completed."
Write-Host "Remote package root: $remotePackage"
