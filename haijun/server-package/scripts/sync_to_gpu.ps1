param(
  [string]$Config = "configs\haijun.yaml"
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $PSScriptRoot)

powershell -ExecutionPolicy Bypass -File scripts\Validate-SyncPackage.ps1

$yamlText = Get-Content -LiteralPath $Config -Raw
$hostLine = ($yamlText -split "`n" | Where-Object { $_ -match "^\s*host:\s*" } | Select-Object -First 1)
$userLine = ($yamlText -split "`n" | Where-Object { $_ -match "^\s*user:\s*" } | Select-Object -First 1)
$portLine = ($yamlText -split "`n" | Where-Object { $_ -match "^\s*port:\s*" } | Select-Object -First 1)
$rootLine = ($yamlText -split "`n" | Where-Object { $_ -match "^\s*remote_root:\s*" } | Select-Object -First 1)

$RemoteHost = ($hostLine -replace "^\s*host:\s*", "").Trim().Trim('"')
$RemoteUser = ($userLine -replace "^\s*user:\s*", "").Trim().Trim('"')
$RemotePort = ($portLine -replace "^\s*port:\s*", "").Trim()
$RemoteRoot = ($rootLine -replace "^\s*remote_root:\s*", "").Trim().Trim('"')

if (-not $RemoteHost -or -not $RemoteUser) {
  throw "Fill remote.host and remote.user in $Config first."
}

$target = "$RemoteUser@$RemoteHost`:$RemoteRoot"

ssh -p $RemotePort "$RemoteUser@$RemoteHost" "mkdir -p $RemoteRoot"
rsync -avz --delete `
  --exclude ".venv" `
  --exclude "models" `
  --exclude "adapters" `
  --exclude "runs" `
  --exclude "data/raw" `
  --exclude ".env" `
  --exclude ".env.*" `
  --exclude "*.gguf" `
  --exclude "*.safetensors" `
  --exclude "*.bin" `
  --exclude "*.pt" `
  --exclude "*.pth" `
  --exclude "*.onnx" `
  --exclude "*.zip" `
  --exclude "*.rar" `
  --exclude "*.7z" `
  --exclude "*.tar" `
  --exclude "*.gz" `
  --exclude "*.xz" `
  -e "ssh -p $RemotePort" `
  ./ $target

Write-Host "Synced Haijun control workspace to $target"
