$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'postgres'

Get-Variable "app"

docker-compose stop --timeout 1 $app
docker-compose rm -f -s -v $app

docker-compose --verbose up $app

Start-Sleep -Seconds 4

