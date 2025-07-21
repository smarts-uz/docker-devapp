$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'git'

. "$root/ALL/App/ALL.ps1"

docker-compose exec -T $app git -v

