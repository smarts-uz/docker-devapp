# smarts Composer AZK laravel_voyager_uztelecom "show --installed"
# smarts Exec-Compose App php php -v
$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/App/ALL.ps1"

$app = $cmds[0]
Get-Variable "cmds"

$cmds.RemoveAt(0)
Get-Variable "cmds"

docker-compose exec -T $app $cmds
