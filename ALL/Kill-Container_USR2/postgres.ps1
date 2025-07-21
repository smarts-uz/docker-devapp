$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'postgres'

. "$root/ALL/Kill-Container_USR2/Azk.ps1"
