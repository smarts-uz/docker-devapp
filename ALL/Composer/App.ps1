# smarts Composer AZK laravel_voyager_uztelecom "show --installed"

$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'php'
. "$root/ALL/App/Path.ps1"



Get-Variable "appPath"

$run = "cd $appDockerPath && composer $($cmds[1])"
Get-Variable "run"

docker-compose exec -T $app bash -c $run
