$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'mariadb'

. "$root/ALL/Rm-Compose-V/Azk.ps1"
