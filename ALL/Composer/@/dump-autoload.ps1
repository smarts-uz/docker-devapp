$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/App/Gits.ps1"

ForEach ($appWindowsPath In $gitsName)
{

    $appDockerPath = "$appLinuxPath/$appWindowsPath"
    . "$root/ALL/Composer/App/dump-autoload.ps1"

}





