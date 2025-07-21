$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'nginx'

. "$root/ALL/Rm-Compose-V/Azk.ps1"
