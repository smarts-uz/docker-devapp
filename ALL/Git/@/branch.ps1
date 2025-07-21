$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/App/Path.ps1"

"Git Branch for $($appPath)"

$branch = $( git branch )
$branch


$branchName = $branch.replace('* ', '')

"Branch Name: $($branchName)"
