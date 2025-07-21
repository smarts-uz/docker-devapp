$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'eimzo'

. "$root/ALL/Kill-Compose_SIGINT/Azk.ps1"
