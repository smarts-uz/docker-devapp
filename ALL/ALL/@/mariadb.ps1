$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'mariadb'

Get-Variable "app"

. "$root/ALL/compose stop/mariadb.ps1"
. "$root/ALL/compose rm/mariadb.ps1"

docker-compose --verbose up $app

Start-Sleep -Seconds 4

