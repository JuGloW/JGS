param(
  [string]$InputPath = "data\curated",
  [string]$OutputPath = "datasets\haijun_sft.jsonl"
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $PSScriptRoot)

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $OutputPath) | Out-Null

$files = @()
if (Test-Path -LiteralPath $InputPath -PathType Leaf) {
  $files += Get-Item -LiteralPath $InputPath
} else {
  $files += Get-ChildItem -LiteralPath $InputPath -Filter *.jsonl | Sort-Object FullName
}

$lines = New-Object System.Collections.Generic.List[string]
foreach ($file in $files) {
  Get-Content -LiteralPath $file.FullName | ForEach-Object {
    $raw = $_.Trim()
    if ($raw) {
      $null = $raw | ConvertFrom-Json
      $lines.Add($raw)
    }
  }
}

$resolvedOutput = Join-Path (Get-Location) $OutputPath
[System.IO.File]::WriteAllLines($resolvedOutput, [string[]]$lines, [System.Text.Encoding]::UTF8)
powershell -ExecutionPolicy Bypass -File scripts\Validate-Dataset.ps1 $OutputPath
Write-Host "Wrote $($lines.Count) examples to $OutputPath"
