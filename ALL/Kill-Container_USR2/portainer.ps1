$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'portainer'

. "$root/ALL/Kill-Container_USR2/Azk.ps1"
