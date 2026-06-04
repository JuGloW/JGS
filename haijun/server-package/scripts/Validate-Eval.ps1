param(
  [string]$EvalPath = "data\eval\haijun_eval_v0_1.jsonl"
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $PSScriptRoot)

$count = 0
$lineNo = 0
$ids = @{}

Get-Content -LiteralPath $EvalPath | ForEach-Object {
  $lineNo += 1
  $raw = $_.Trim()
  if (-not $raw) {
    return
  }
  $item = $raw | ConvertFrom-Json
  if (-not $item.id) {
    throw "line ${lineNo}: missing id"
  }
  if ($ids.ContainsKey($item.id)) {
    throw "line ${lineNo}: duplicate id $($item.id)"
  }
  $ids[$item.id] = $true
  if (-not $item.category) {
    throw "line ${lineNo}: missing category"
  }
  if (-not $item.prompt) {
    throw "line ${lineNo}: missing prompt"
  }
  if (-not $item.checks -or $item.checks.Count -eq 0) {
    throw "line ${lineNo}: checks must be non-empty"
  }
  foreach ($check in $item.checks) {
    if (-not $check.id) {
      throw "line ${lineNo}: check missing id"
    }
    if ((-not $check.any -or $check.any.Count -eq 0) -and (-not $check.all -or $check.all.Count -eq 0)) {
      throw "line ${lineNo}: check $($check.id) needs any or all"
    }
  }
  $count += 1
}

Write-Host "OK: $count eval items validated in $EvalPath"

