param(
  [Parameter(Mandatory = $true)]
  [string]$Dataset
)

$ErrorActionPreference = "Stop"
$validRoles = @("system", "user", "assistant")
$count = 0
$lineNo = 0

Get-Content -LiteralPath $Dataset | ForEach-Object {
  $lineNo += 1
  $raw = $_.Trim()
  if (-not $raw) {
    return
  }

  $item = $raw | ConvertFrom-Json
  if (-not $item.messages -or $item.messages.Count -eq 0) {
    throw "line ${lineNo}: messages must be a non-empty list"
  }

  for ($i = 0; $i -lt $item.messages.Count; $i += 1) {
    $message = $item.messages[$i]
    if ($validRoles -notcontains $message.role) {
      throw "line ${lineNo}: invalid role '$($message.role)'"
    }
    if (-not $message.content -or -not $message.content.Trim()) {
      throw "line ${lineNo}: empty content in message $i"
    }
  }

  $count += 1
}

Write-Host "OK: $count examples validated in $Dataset"

