$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'portainer'

. "$root/ALL/Build-Compose-Nc/Azk.ps1"
