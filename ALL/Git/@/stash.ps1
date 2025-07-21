$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/App/Gits.ps1"

ForEach ($appPath In $gits)
{


    . "$root/ALL/Git/App/stash.ps1"

}





