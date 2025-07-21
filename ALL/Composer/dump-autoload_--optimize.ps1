# smarts Composer dump-autoload_--optimize laravel_voyager_uztelecom

$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'php'
. "$root/ALL/App/Path.ps1"



Get-Variable "appPath"

$run = "cd $appDockerPath && composer dump-autoload --optimize"
Get-Variable "run"

docker-compose exec -T $app bash -c $run
