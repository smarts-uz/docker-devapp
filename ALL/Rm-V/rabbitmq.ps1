$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'rabbitmq'

. "$root/ALL/Rm-V/Azk.ps1"
