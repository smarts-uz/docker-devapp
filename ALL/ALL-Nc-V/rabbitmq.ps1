$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'rabbitmq'

. "$root/ALL/ALL-Nc-V/Azk.ps1"
