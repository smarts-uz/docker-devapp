$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'php'
. "$root/ALL/App/Path.ps1"


Get-Variable "appPath"

$run = "cd $appDockerPath && composer install --prefer-dist"
Get-Variable "run"

docker-compose exec -T $app bash -c $run
