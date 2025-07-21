$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'mongo'

. "$root/ALL/ALL-Nc/Azk.ps1"
