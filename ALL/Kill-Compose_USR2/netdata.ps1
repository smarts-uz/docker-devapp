$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'netdata'

. "$root/ALL/Kill-Compose_USR2/Azk.ps1"
