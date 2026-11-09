# This file DOES NOT start Codex or change Windows shortcuts.
$ErrorActionPreference='Continue'
Write-Host '=== Codex apps in StartApps ===' -ForegroundColor Cyan
try {
  Get-StartApps | Where-Object { $_.Name -match 'Codex|ChatGPT' -or $_.AppID -match 'OpenAI\.Codex' } |
    Select-Object Name,AppID | Format-Table -AutoSize | Out-Host
} catch { Write-Host $_.Exception.Message -ForegroundColor Red }
Write-Host '=== Configuration ===' -ForegroundColor Cyan
try {
  $cfg=Get-Content -LiteralPath (Join-Path $PSScriptRoot 'launcher.json') -Raw -Encoding UTF8 | ConvertFrom-Json
  Write-Host ('AppLaunch: ' + $cfg.AppLaunch)
  Write-Host ('ProcessPathContains: ' + $cfg.ProcessPathContains)
  Write-Host ('ProcessNames: ' + ($cfg.ProcessNames -join ', '))
} catch { Write-Host $_.Exception.Message -ForegroundColor Red }
Write-Host '=== Running processes ===' -ForegroundColor Cyan
Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'Codex|ChatGPT' } |
  Select-Object Name,ProcessId,ExecutablePath | Format-List | Out-Host
$log=Join-Path $PSScriptRoot 'logs\launcher.log'
if (Test-Path -LiteralPath $log) {
 Write-Host '=== Last 40 launcher log lines ===' -ForegroundColor Cyan
 Get-Content -LiteralPath $log -Tail 40 | Out-Host
}
Write-Host ''
Write-Host 'If AppLaunch does not match the installed AppID, edit launcher.json.' -ForegroundColor Yellow
