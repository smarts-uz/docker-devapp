$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = $cmds

. "$root/ALL/Up-Compose/Azk.ps1"
