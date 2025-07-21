chcp 65001

$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/Prune-Container/ALL.ps1"
. "$root/ALL/Prune-Image/ALL.ps1"
. "$root/ALL/Prune-Network/ALL.ps1"
. "$root/ALL/Prune-Volume/ALL.ps1"
