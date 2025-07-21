$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/App/Gits.ps1"

ForEach ($appPath In $gits)
{


    . "$root/ALL/Git/App/reset.ps1"
    . "$root/ALL/Git/App/pull.ps1"

}





