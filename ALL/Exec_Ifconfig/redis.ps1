$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'redis'

. "$root/ALL/Exec_Ifconfig/Azk.ps1"
