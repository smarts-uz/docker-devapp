$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"


. "$root/ALL/App/Path.ps1"

"Git Branch for $($appPath)"

$branch = $( git branch )
Get-Variable "branch"


$branchName = $branch.replace('* ', '')
Get-Variable "branchName"


"Starting Git Pull for:|" + $appPath + "|"

Set-Location $appPath
git pull --progress -v --no-rebase "origin" $branchName
