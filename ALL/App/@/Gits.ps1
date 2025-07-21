$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/App/Path.ps1"

$gits = Get-ChildItem -Path "$appWindowsPath/*" -Directory

"Gits"
Write-Host $gits


$gitsName = Get-ChildItem -Path "$appWindowsPath/*" -Directory -Name

"GitsName"
Write-Host $gitsName


