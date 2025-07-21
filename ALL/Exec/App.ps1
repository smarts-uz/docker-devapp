# smarts Composer AZK laravel_voyager_uztelecom "show --installed"
# smarts Exec-Compose AZK php php -v
$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = $cmds[0]
Get-Variable "cmds"

$cmds.RemoveAt(0)
Get-Variable "cmds"

docker exec -i $app $cmds
