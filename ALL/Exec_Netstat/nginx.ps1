$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'nginx'

. "$root/ALL/Exec_Netstat/Azk.ps1"
