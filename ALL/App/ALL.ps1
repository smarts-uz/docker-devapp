. "$root/ALL/App/Init.ps1"

<#
    Set DB pass
#>

$passDB = 'rootpass' + '4' + '4' + '5'
$passRoot = 'rootapp' + '2' + '4' + '1' + '2' + '$'

[System.Environment]::SetEnvironmentVariable('ROOT_PASSWORD', $passRoot)
[System.Environment]::SetEnvironmentVariable('DB_PASSWORD', $passDB)



<#
    Set HTTP ports
#>

if (Test-Path -Path "D:")
{
    $portHttp = $env:PORT_NGNIX_HTTP_Windows
    $portHttps = $env:PORT_NGNIX_HTTPS_Windows
}
else
{
    $portHttp = $env:PORT_NGNIX_HTTP_Linux
    $portHttps = $env:PORT_NGNIX_HTTPS_Linux
}

[System.Environment]::SetEnvironmentVariable('PORT_HTTP', $portHttp)
[System.Environment]::SetEnvironmentVariable('PORT_HTTPS', $portHttps)

Get-Variable "portHttp"
Get-Variable "portHttps"
