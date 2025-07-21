# smarts Artisan storage-link laravel_voyager_uztelecom

$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'php'

. "$root/ALL/App/Path.ps1"


"Move Storage-Link for:|" + $appDockerPath + "|"

$time = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

$run = "mv $appDockerPath/public/storage $appDockerPath/public/storage_$($time)"
$run
docker-compose exec -T $app bash -c $run


"Create New Storage-Link for:|" + $appDockerPath + "|"

$run = "cd $appDockerPath && echo $PATH && php artisan storage:link"
$run
docker-compose exec -T $app bash -c $run

