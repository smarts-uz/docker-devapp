$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
. "$root/ALL/App/ALL.ps1"

$app = 'mariadb'

Get-Variable "app"

docker-compose top $app

Start-Sleep -Seconds 4




