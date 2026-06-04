param(
  [string]$PackagePath = "server-package",
  [string]$OutputZip = "dist\haijun-server-package.zip"
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $PSScriptRoot)

powershell -ExecutionPolicy Bypass -File scripts\Build-ServerPackage.ps1 -Output $PackagePath

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $OutputZip) | Out-Null

$forbidden = Get-ChildItem -LiteralPath $PackagePath -Recurse -File -Force |
  Where-Object {
    $_.Extension.ToLowerInvariant() -in @(".gguf", ".safetensors", ".bin", ".pt", ".pth", ".onnx", ".zip", ".rar", ".7z", ".tar", ".gz", ".xz") -or
    $_.Name -eq ".env" -or
    $_.Name -like ".env.*"
  }

if ($forbidden) {
  $forbidden | Select-Object FullName
  throw "server package contains forbidden artifacts"
}

$packageItems = Get-ChildItem -LiteralPath $PackagePath -Force
Compress-Archive -Path $packageItems.FullName -DestinationPath $OutputZip -Force

$zip = Get-Item -LiteralPath $OutputZip
Write-Host "OK: packed server package to $OutputZip ($($zip.Length) bytes)"
