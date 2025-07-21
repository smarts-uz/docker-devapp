$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/App/Gits.ps1"

$app = 'nginx'


ForEach ($appWindowsPath In $gitsName)
{

    $appPath = "$appLinuxPath/$appWindowsPath"
    . "$root/ALL/LN/App/symlink-storage.ps1"

}





