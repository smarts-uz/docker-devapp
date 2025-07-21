$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
Set-Location $root$app = 'git'

. "$root/ALL/ALL-Nc-V/Azk.ps1"
