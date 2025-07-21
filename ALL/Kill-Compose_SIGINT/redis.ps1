$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'redis'

. "$root/ALL/Kill-Compose_SIGINT/Azk.ps1"
