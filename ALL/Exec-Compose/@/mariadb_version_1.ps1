$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'mariadb'
$run = ' mysqld -v'

Set-Location $root

'App Name: '
Get-Variable "app"

'Running Cmd: '
Get-Variable "run"
Write-Host $exec

$exec = 'docker-compose exec -T mariadb mysqld -v'
$result = Invoke-Expression $exec
$result

