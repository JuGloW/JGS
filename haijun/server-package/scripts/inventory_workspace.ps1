param(
  [string]$Root = "D:\github AI",
  [string]$Out = "data\raw\workspace_inventory.txt"
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $PSScriptRoot)
New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Out) | Out-Null

Get-ChildItem -LiteralPath $Root -Recurse -File |
  Where-Object {
    $_.FullName -notmatch "\\haijun-ai\\models\\" -and
    $_.FullName -notmatch "\\haijun-ai\\adapters\\" -and
    $_.FullName -notmatch "\\haijun-ai\\runs\\"
  } |
  Select-Object FullName, Length, LastWriteTime |
  Format-Table -AutoSize |
  Out-String -Width 240 |
  Set-Content -LiteralPath $Out -Encoding UTF8

Write-Host "Inventory written to $Out"

