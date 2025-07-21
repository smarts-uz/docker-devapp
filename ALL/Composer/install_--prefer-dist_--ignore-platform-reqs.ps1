# smarts Composer install_--prefer-dist_--ignore-platform-reqs laravel_voyager_uztelecom

$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'php'
. "$root/ALL/App/Path.ps1"

$run = "cd $appDockerPath && composer install --prefer-dist --ignore-platform-reqs"
$run

docker-compose exec -T $app bash -c $run
