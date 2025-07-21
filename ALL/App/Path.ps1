. "$root/ALL/App/Init.ps1"

Get-Variable "cmds"

If ($IsLinux)
{
    $appPath = "$( $mainLinuxPath )/$( $cmds[0] )"
}
else
{
    $appPath = "$( $mainWindowsPath )/$( $cmds[0] )"
}
Get-Variable "appPath"

$appDockerPath = "$( $mainDockerPath )/$( $cmds[0] )"
Get-Variable "appDockerPath"






