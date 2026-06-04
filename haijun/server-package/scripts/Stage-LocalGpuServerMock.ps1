param(
  [string]$SourcePackage = "server-package",
  [string]$MockRoot = "D:\GPU-server",
  [string]$MockPackage = "haijun-ai\server-package"
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $PSScriptRoot)

$sourcePath = Join-Path (Get-Location) $SourcePackage
$targetPath = Join-Path $MockRoot $MockPackage

if (-not (Test-Path -LiteralPath $sourcePath)) {
  powershell -ExecutionPolicy Bypass -File scripts\Build-ServerPackage.ps1 -Output $SourcePackage
}

$forbidden = Get-ChildItem -LiteralPath $sourcePath -Recurse -File -Force |
  Where-Object {
    $_.Extension.ToLowerInvariant() -in @(".gguf", ".safetensors", ".bin", ".pt", ".pth", ".onnx", ".zip", ".rar", ".7z", ".tar", ".gz", ".xz") -or
    $_.Name -eq ".env" -or
    $_.Name -like ".env.*"
  }

if ($forbidden) {
  $forbidden | Select-Object FullName
  throw "server-package contains forbidden artifacts"
}

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $targetPath) | Out-Null
if (Test-Path -LiteralPath $targetPath) {
  Remove-Item -LiteralPath $targetPath -Recurse -Force
}

Copy-Item -LiteralPath $sourcePath -Destination $targetPath -Recurse -Force

Write-Host "OK: staged local GPU server mock"
Write-Host "Source: $sourcePath"
Write-Host "Target: $targetPath"
Write-Host "Use this as local stand-in for: ~/haijun-ai/server-package"

