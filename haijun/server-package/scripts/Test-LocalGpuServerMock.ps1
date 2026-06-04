param(
  [string]$MockPackagePath = "D:\GPU-server\haijun-ai\server-package"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $MockPackagePath)) {
  throw "Mock package path not found: $MockPackagePath"
}

Set-Location $MockPackagePath
$reportDir = Join-Path $MockPackagePath "runs\server-inspection"
New-Item -ItemType Directory -Force -Path $reportDir | Out-Null
$timestamp = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
$reportTxt = Join-Path $reportDir "local-mock-inspection-$timestamp.txt"
$factsJsonl = Join-Path $reportDir "local-mock-inspection-$timestamp.facts.jsonl"

function Write-Fact {
  param(
    [string]$Key,
    [string]$Value
  )
  $obj = [ordered]@{
    key = $Key
    value = $Value
  }
  ($obj | ConvertTo-Json -Compress) | Add-Content -LiteralPath $factsJsonl
}

Start-Transcript -LiteralPath $reportTxt -Force | Out-Null

Write-Host "== Haijun local GPU-server mock =="
Write-Host "Mock path: $MockPackagePath"
Write-Host "This simulates: ~/haijun-ai/server-package"
Write-Host "Report TXT: $reportTxt"
Write-Host "Facts JSONL: $factsJsonl"
Write-Host ""
Write-Fact "mock_path" $MockPackagePath
Write-Fact "simulated_server_path" "~/haijun-ai/server-package"
Write-Fact "report_txt" $reportTxt
Write-Fact "facts_jsonl" $factsJsonl

Write-Host "== OS =="
$os = Get-CimInstance Win32_OperatingSystem
$os | Select-Object Caption, Version, OSArchitecture | Format-Table -AutoSize
Write-Fact "os_caption" $os.Caption
Write-Fact "os_version" $os.Version
Write-Fact "os_architecture" $os.OSArchitecture

Write-Host "== Disk =="
$drive = (Get-Item -LiteralPath $MockPackagePath).PSDrive.Name
$driveInfo = Get-PSDrive -Name $drive
$driveInfo | Select-Object Name,Used,Free,Root | Format-Table -AutoSize
Write-Fact "disk_drive" $driveInfo.Name
Write-Fact "disk_root" $driveInfo.Root
Write-Fact "disk_used_bytes" ([string]$driveInfo.Used)
Write-Fact "disk_free_bytes" ([string]$driveInfo.Free)

Write-Host "== Python =="
$pythonCommands = @("python", "py", "python3")
$pythonFound = $false
foreach ($cmd in $pythonCommands) {
  $found = Get-Command $cmd -ErrorAction SilentlyContinue
  if ($found) {
    $pythonFound = $true
    Write-Host "$cmd found: $($found.Source)"
    Write-Fact "python_$cmd_path" $found.Source
    try {
      $version = & $cmd --version
      Write-Host $version
      Write-Fact "python_$cmd_version" ($version -join " ")
    } catch {
      Write-Host "$cmd exists but version check failed: $($_.Exception.Message)"
      Write-Fact "python_$cmd_version" "version-check-failed"
    }
  }
}
if (-not $pythonFound) {
  Write-Host "python not found in PATH. This is acceptable for mock testing; server will need python3."
  Write-Fact "python_status" "missing"
} else {
  Write-Fact "python_status" "found"
}

Write-Host "== GPU presence =="
$gpus = Get-CimInstance Win32_VideoController
$gpus | Select-Object Name,AdapterCompatibility,AdapterRAM | Format-Table -AutoSize
Write-Fact "gpu_count" ([string]@($gpus).Count)
Write-Fact "gpu_names" (($gpus | ForEach-Object { $_.Name }) -join "; ")

Write-Host "== nvidia-smi =="
$nvidia = Get-Command nvidia-smi -ErrorAction SilentlyContinue
if ($nvidia) {
  Write-Fact "nvidia_smi_status" "found"
  Write-Fact "nvidia_smi_path" $nvidia.Source
  & nvidia-smi
} else {
  Write-Host "nvidia-smi not found; OK for CPU-only/mock preparation."
  Write-Fact "nvidia_smi_status" "missing"
}

Write-Host "== Package structure =="
$required = @(
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
  "requirements-gpu.txt"
)
foreach ($path in $required) {
  if (-not (Test-Path -LiteralPath $path)) {
    throw "missing package path: $path"
  }
}
Write-Host "OK: required package paths exist."
Write-Fact "package_structure" "valid"

Write-Host "== Forbidden artifacts =="
$forbidden = Get-ChildItem -Recurse -File -Force |
  Where-Object {
    $_.Extension.ToLowerInvariant() -in @(".gguf", ".safetensors", ".bin", ".pt", ".pth", ".onnx", ".zip", ".rar", ".7z", ".tar", ".gz", ".xz") -or
    $_.Name -eq ".env" -or
    $_.Name -like ".env.*"
  }
if ($forbidden) {
  $forbidden | Select-Object FullName,Length
  throw "forbidden artifacts found in mock package"
}
Write-Host "OK: no model weights, archives, or env files found."
Write-Fact "forbidden_artifacts" "none"

Write-Host "== Dataset validation =="
powershell -ExecutionPolicy Bypass -File scripts\Validate-Dataset.ps1 datasets\haijun_sft.jsonl
Write-Fact "dataset_validation" "valid"
Write-Fact "dataset_lines" ([string](Get-Content -LiteralPath "datasets\haijun_sft.jsonl").Count)

Write-Host "== Eval validation =="
powershell -ExecutionPolicy Bypass -File scripts\Validate-Eval.ps1 data\eval\haijun_eval_v0_1.jsonl
Write-Fact "eval_validation" "valid"
Write-Fact "eval_lines" ([string](Get-Content -LiteralPath "data\eval\haijun_eval_v0_1.jsonl").Count)

Write-Host "== Summary =="
$fileStats = Get-ChildItem -Recurse -File | Measure-Object -Property Length -Sum
Write-Host "Files: $($fileStats.Count)"
Write-Host "Bytes: $($fileStats.Sum)"
Write-Host "Report TXT: $reportTxt"
Write-Host "Facts JSONL: $factsJsonl"
Write-Fact "file_count" ([string]$fileStats.Count)
Write-Fact "byte_count" ([string]$fileStats.Sum)
Write-Host "OK: local mock server package test completed. No install or model download was performed."
Stop-Transcript | Out-Null
