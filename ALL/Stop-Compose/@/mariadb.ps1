$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'mariadb'

Get-Variable "app"

docker-compose stop --timeout 1 $app

Start-Sleep -Seconds 4




