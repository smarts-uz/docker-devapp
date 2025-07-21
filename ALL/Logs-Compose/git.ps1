$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'git'

. "$root/ALL/Logs-Compose/Azk.ps1"
