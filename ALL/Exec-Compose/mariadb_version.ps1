$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'mariadb'

. "$root/ALL/App/ALL.ps1"

docker-compose exec -T $app mysqld -v
