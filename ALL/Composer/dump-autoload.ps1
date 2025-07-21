# smarts Composer dump-autoload laravel_voyager_uztelecom

$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'php'
. "$root/ALL/App/Path.ps1"

$run = "cd $appDockerPath && composer dump-autoload"
Get-Variable "run"

docker-compose exec -T $app bash -c $run
