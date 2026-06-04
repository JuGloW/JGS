param(
  [string]$EvalPath = "data\eval\haijun_eval_v0_1.jsonl",
  [string]$AnswersPath = "data\eval\sample_answers_v0_1.jsonl",
  [string]$ReportPath = "runs\eval\haijun_eval_report.json"
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $PSScriptRoot)

function Read-Jsonl($Path) {
  $items = @()
  $lineNo = 0
  Get-Content -LiteralPath $Path | ForEach-Object {
    $lineNo += 1
    $raw = $_.Trim()
    if ($raw) {
      $item = $raw | ConvertFrom-Json
      $item | Add-Member -NotePropertyName "_line" -NotePropertyValue $lineNo -Force
      $items += $item
    }
  }
  return $items
}

function Test-ContainsAny($Text, $Needles) {
  if (-not $Needles -or $Needles.Count -eq 0) {
    return $true
  }
  foreach ($needle in $Needles) {
    if ($Text.Contains($needle.ToLowerInvariant())) {
      return $true
    }
  }
  return $false
}

function Test-ContainsAll($Text, $Needles) {
  if (-not $Needles -or $Needles.Count -eq 0) {
    return $true
  }
  foreach ($needle in $Needles) {
    if (-not $Text.Contains($needle.ToLowerInvariant())) {
      return $false
    }
  }
  return $true
}

$evals = Read-Jsonl $EvalPath
$answers = Read-Jsonl $AnswersPath
$answerMap = @{}
foreach ($answer in $answers) {
  $answerMap[$answer.id] = $answer.answer
}

$results = @()
$passedItems = 0
$criticalPassedItems = 0
$totalChecks = 0
$passedChecks = 0

foreach ($item in $evals) {
  $answer = ""
  if ($answerMap.ContainsKey($item.id)) {
    $answer = [string]$answerMap[$item.id]
  }
  $text = $answer.ToLowerInvariant()
  $checkResults = @()
  $itemPassedChecks = 0
  $itemTotalChecks = 0

  foreach ($check in $item.checks) {
    $itemTotalChecks += 1
    $totalChecks += 1
    $anyPass = Test-ContainsAny $text $check.any
    $allPass = Test-ContainsAll $text $check.all
    $pass = $anyPass -and $allPass
    if ($pass) {
      $itemPassedChecks += 1
      $passedChecks += 1
    }
    $checkResults += [pscustomobject]@{
      id = $check.id
      pass = $pass
    }
  }

  $criticalIds = @($item.critical)
  $criticalPass = $true
  foreach ($criticalId in $criticalIds) {
    $match = $checkResults | Where-Object { $_.id -eq $criticalId } | Select-Object -First 1
    if (-not $match -or -not $match.pass) {
      $criticalPass = $false
      break
    }
  }

  $itemPass = $itemTotalChecks -gt 0 -and $itemPassedChecks -eq $itemTotalChecks
  if ($itemPass) {
    $passedItems += 1
  }
  if ($criticalPass) {
    $criticalPassedItems += 1
  }

  $results += [pscustomobject]@{
    id = $item.id
    category = $item.category
    has_answer = [bool]$answer
    passed_checks = $itemPassedChecks
    total_checks = $itemTotalChecks
    pass = $itemPass
    critical_pass = $criticalPass
    checks = $checkResults
  }
}

$summary = [pscustomobject]@{
  eval_path = $EvalPath
  answers_path = $AnswersPath
  total_items = $evals.Count
  answered_items = ($results | Where-Object { $_.has_answer }).Count
  passed_items = $passedItems
  critical_passed_items = $criticalPassedItems
  total_checks = $totalChecks
  passed_checks = $passedChecks
  check_score = if ($totalChecks -gt 0) { [math]::Round($passedChecks / $totalChecks, 4) } else { 0 }
  critical_item_score = if ($evals.Count -gt 0) { [math]::Round($criticalPassedItems / $evals.Count, 4) } else { 0 }
}

$report = [pscustomobject]@{
  summary = $summary
  results = $results
}

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $ReportPath) | Out-Null
$json = $report | ConvertTo-Json -Depth 8
[System.IO.File]::WriteAllText((Join-Path (Get-Location) $ReportPath), $json, [System.Text.Encoding]::UTF8)

Write-Host "Eval report written to $ReportPath"
Write-Host "Items: $($summary.passed_items)/$($summary.total_items) full pass"
Write-Host "Critical: $($summary.critical_passed_items)/$($summary.total_items)"
Write-Host "Checks: $($summary.passed_checks)/$($summary.total_checks) score=$($summary.check_score)"

