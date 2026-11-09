$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot
$framework = Join-Path $env:WINDIR 'Microsoft.NET/Framework64/v4.0.30319'
$output = Join-Path $root 'build/DragonCodexBoot'
New-Item -ItemType Directory -Force $output | Out-Null
$exe = Join-Path $output 'DragonCodexBoot.exe'
$references = @('WPF/WindowsBase.dll','WPF/PresentationCore.dll','WPF/PresentationFramework.dll','System.Web.Extensions.dll','System.Xaml.dll') |
    ForEach-Object { '/reference:' + (Join-Path $framework $_) }
& (Join-Path $framework 'csc.exe') /nologo /target:winexe /optimize+ /codepage:65001 "/out:$exe" "/win32manifest:$root\source\app.manifest" $references "$root\source\DragonCodexBoot.cs"
if ($LASTEXITCODE -ne 0) { throw 'Compilation failed.' }
Copy-Item "$root/scripts","$root/*.cmd","$root/Diagnose-Codex.ps1","$root/LICENSE","$root/THIRD_PARTY_NOTICES.md" $output -Recurse -Force
if (!(Test-Path "$output/launcher.json")) { Copy-Item "$root/launcher.json" $output }
$result = Start-Process -FilePath $exe -ArgumentList '--self-test' -WindowStyle Hidden -Wait -PassThru
if ($result.ExitCode -ne 0) { throw "Self-test failed. See $output/self-test-error.txt." }
Get-Content "$output/qa/self-test.json"

