$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/App/List.ps1"



Get-Variable "apps"


Get-Variable "appsStr"
# docker-compose down

ForEach ($app In $apps)
{

    Get-Variable "app"

}


Get-Variable "appsStr".GetType();

# docker-compose --verbose up $appsStr
# docker-compose

$argList = "--verbose up eimzo mariadb netdata nginx php portainer postgres redis"
$appWindowsPath = '"c:/Program Files/Docker/Docker/resources/bin/docker-compose.exe"'

# Start-Process -FilePath $appWindowsPath -ArgumentList $argList -Wait


$str =  'docker-compose --verbose up ' + $appsStr

$outcome = $run = 'docker-compose --verbose up ' + $appsStr
Invoke-Expression $run
$outcome

# docker-compose $argList

Start-Sleep -Seconds 4

