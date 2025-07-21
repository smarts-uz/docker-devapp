$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/App/Path.ps1"

"Starting Git Stash Save: " + $appPath

Set-Location $appPath

git stash push --staged

# git stash save "AAA"
# git stash
# git stash save --staged


