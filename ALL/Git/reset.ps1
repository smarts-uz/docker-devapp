$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/App/Path.ps1"

"Starting Git Reset for: " + $appPath

Set-Location $appPath
git reset --hard HEAD
