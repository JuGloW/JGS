param(
  [string]$Root = ".",
  [int]$MaxFileSizeMb = 5
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path -Parent $PSScriptRoot)

$forbiddenDirs = @(
  "\.venv",
  "\models",
  "\adapters",
  "\runs",
  "\data\raw",
  "\server-package",
  "\dist"
)

$forbiddenExtensions = @(
  ".gguf",
  ".safetensors",
  ".bin",
  ".pt",
  ".pth",
  ".onnx",
  ".zip",
  ".rar",
  ".7z",
  ".tar",
  ".gz",
  ".xz"
)

$forbiddenNames = @(
  ".env"
)

$secretRegexes = @(
  "-----BEGIN OPENSSH PRIVATE KEY-----",
  "-----BEGIN RSA PRIVATE KEY-----",
  "-----BEGIN PRIVATE KEY-----",
  "hf_[A-Za-z0-9]{20,}",
  "ghp_[A-Za-z0-9]{20,}",
  "github_pat_[A-Za-z0-9_]{20,}",
  "sk-[A-Za-z0-9]{20,}"
)

$maxBytes = $MaxFileSizeMb * 1024 * 1024
$problems = New-Object System.Collections.Generic.List[string]
$rootPath = (Resolve-Path -LiteralPath $Root).Path

$files = Get-ChildItem -LiteralPath $rootPath -Recurse -File -Force
foreach ($file in $files) {
  $relative = $file.FullName.Substring($rootPath.Length).TrimStart("\", "/")
  $relativeForMatch = "\" + ($relative -replace "/", "\")

  $isExcludedDir = $false
  foreach ($dir in $forbiddenDirs) {
    if ($relativeForMatch.StartsWith($dir + "\") -or $relativeForMatch -eq $dir) {
      $isExcludedDir = $true
      break
    }
  }
  if ($isExcludedDir) {
    continue
  }

  if ($forbiddenNames -contains $file.Name) {
    $problems.Add("forbidden name: $relative")
  }

  if ($forbiddenExtensions -contains $file.Extension.ToLowerInvariant()) {
    $problems.Add("forbidden extension: $relative")
  }

  if ($file.Length -gt $maxBytes) {
    $allowedLarge = $relative -in @(
      "references\copied-key-files\haicode_data_instruction_set.txt",
      "references\copied-key-files\syscalls.master",
      "references\portable-ai\PortableLM_chat_server.py"
    )
    if (-not $allowedLarge) {
      $problems.Add("file exceeds ${MaxFileSizeMb}MB: $relative ($($file.Length) bytes)")
    }
  }

  $skipSecretScan = $relative -eq "scripts\Validate-SyncPackage.ps1"
  if (-not $skipSecretScan -and $file.Length -le 1048576 -and $file.Extension.ToLowerInvariant() -in @(".txt", ".md", ".yaml", ".yml", ".json", ".jsonl", ".py", ".ps1", ".sh", ".bat", ".cmd", ".toml", ".h", ".in")) {
    $content = Get-Content -LiteralPath $file.FullName -Raw -ErrorAction SilentlyContinue
    foreach ($pattern in $secretRegexes) {
      if ($content -and [regex]::IsMatch($content, $pattern)) {
        $problems.Add("possible secret pattern '$pattern': $relative")
      }
    }
  }
}

if ($problems.Count -gt 0) {
  Write-Host "Sync package validation failed:"
  foreach ($problem in $problems) {
    Write-Host " - $problem"
  }
  exit 1
}

Write-Host "OK: sync package validation passed."
Write-Host "Checked $($files.Count) files under $rootPath"
