# smarts Artisan websocket-serve laravel_voyager_uztelecom

$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
$app = 'php'

. "$root/ALL/App/Path.ps1"


"Run Websocket for:|" + $appDockerPath + "|"

$run = "cd $appDockerPath && php artisan websocket:serve"
$run
docker-compose exec -T $app bash -c $run



