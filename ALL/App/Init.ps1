
<#
    Get content from ENV
#>

Get-Content .env | ForEach-Object {
    $name, $value = $_.split('=')

    if (-not([string]::IsNullOrEmpty($value)))
    {
        Set-Content Env:\$name $value
    }
}



<#
    Prepare Vars
#>


Get-Variable "root"
Get-Variable "args"
Write-Output "Args Count: $( $args.count )"
Write-Output [System.Environment]::OSVersion.Platform

$appRoot = $root | Split-Path
Get-Variable "appRoot"

$mainWindowsPath = "$( $appRoot )/Apps"
Get-Variable "mainWindowsPath"

$mainLinuxPath = "/var/app/Apps"
Get-Variable "mainLinuxPath"

$mainDockerPath = "/var/www"
Get-Variable "mainDockerPath"

