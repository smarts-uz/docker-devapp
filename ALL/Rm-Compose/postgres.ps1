$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'postgres'

. "$root/ALL/Compose-Rm/Azk.ps1"
