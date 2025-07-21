$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root


<#
    Verify Args
#>

if ($args.count -lt 2)
{
    Write-Output 'Incorrect Argument count'
    exit
}

<#
    Command Line
#>


$folder = $args[0]
$file = $args[1]

$cmds = New-Object System.Collections.ArrayList(,$args)

$cmds.RemoveAt(0)
$cmds.RemoveAt(0)

Write-Host $cmds


<#
    Execute Scripts
#>




If ([System.Environment]::OSVersion.Platform -eq 'Win32NT')
{
    . "D:\Develop\Projects\docker\ALL\ALL\$( $folder )\$( $file ).ps1"
}
else
{
    . "/var/app/ALL/ALL/$( $folder )/$( $file ).ps1"
}

$result

