param(
  [string]$Output = "server-package"
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $PSScriptRoot)

powershell -ExecutionPolicy Bypass -File scripts\Validate-SyncPackage.ps1

$outputPath = Join-Path (Get-Location) $Output
New-Item -ItemType Directory -Force -Path $outputPath | Out-Null
$projectRoot = (Get-Location).Path
$resolvedOutput = (Resolve-Path -LiteralPath $outputPath).Path
if (-not $resolvedOutput.StartsWith($projectRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
  throw "refusing to build package outside project root: $resolvedOutput"
}

function Remove-PackagePath {
  param([string]$Path)

  if (-not (Test-Path -LiteralPath $Path)) {
    return
  }

  $resolved = (Resolve-Path -LiteralPath $Path).Path
  if (-not $resolved.StartsWith($resolvedOutput, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "refusing to remove path outside server package: $resolved"
  }

  if ((Get-Item -LiteralPath $Path).PSIsContainer) {
    Get-ChildItem -LiteralPath $Path -Force -Recurse |
      Sort-Object FullName -Descending |
      ForEach-Object {
        Remove-Item -LiteralPath $_.FullName -Force -Recurse
      }
    Remove-Item -LiteralPath $Path -Force
  } else {
    Remove-Item -LiteralPath $Path -Force
  }
}

$items = @(
  "configs",
  "data\curated",
  "data\eval",
  "datasets",
  "docs",
  "memory",
  "references",
  "remote",
  "scripts",
  "src",
  "pyproject.toml",
  "requirements-gpu.txt"
)

foreach ($item in $items) {
  $src = Join-Path (Get-Location) $item
  if (-not (Test-Path -LiteralPath $src)) {
    throw "missing package source: $item"
  }
  $dst = Join-Path $outputPath $item
  if ((Get-Item -LiteralPath $src).PSIsContainer) {
    New-Item -ItemType Directory -Force -Path $dst | Out-Null
    Get-ChildItem -LiteralPath $src -Force |
      ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination $dst -Recurse -Force
      }
  } else {
    Copy-Item -LiteralPath $src -Destination $dst -Force
  }
}

Copy-Item -LiteralPath (Join-Path (Get-Location) "docs\SERVER_PACKAGE_README.md") -Destination (Join-Path $outputPath "README.md") -Force

$forbidden = Get-ChildItem -LiteralPath $outputPath -Recurse -File -Force |
  Where-Object {
    $_.Extension.ToLowerInvariant() -in @(".gguf", ".safetensors", ".bin", ".pt", ".pth", ".onnx", ".zip", ".rar", ".7z", ".tar", ".gz", ".xz") -or
    $_.Name -eq ".env" -or
    $_.Name -like ".env.*"
  }

if ($forbidden) {
  $forbidden | Select-Object FullName
  throw "server package contains forbidden artifacts"
}

Write-Host "OK: server package built at $outputPath"
