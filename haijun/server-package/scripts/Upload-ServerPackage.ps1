param(
  [Parameter(Mandatory = $true)]
  [string]$HostAlias,
  [string]$ZipPath = "dist\haijun-server-package.zip",
  [string]$RemoteRoot = "~/haijun-ai",
  [int]$Port = 22
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $PSScriptRoot)

if (-not (Test-Path -LiteralPath $ZipPath)) {
  powershell -ExecutionPolicy Bypass -File scripts\Pack-ServerPackage.ps1 -OutputZip $ZipPath
}

Write-Host "Creating remote root: $RemoteRoot"
ssh -p $Port $HostAlias "mkdir -p $RemoteRoot"

Write-Host "Uploading $ZipPath to $HostAlias:$RemoteRoot/"
scp -P $Port $ZipPath "$HostAlias`:$RemoteRoot/haijun-server-package.zip"

Write-Host "Upload complete."
Write-Host "Next on server:"
Write-Host "  cd $RemoteRoot"
Write-Host "  rm -rf server-package"
Write-Host "  unzip -o haijun-server-package.zip -d server-package"
Write-Host "  cd server-package"
Write-Host "  bash remote/server/validate_server_package.sh"
Write-Host "  bash remote/server/bootstrap_server_cpu.sh"

