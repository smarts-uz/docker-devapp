"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
. "$root/ALL/App/ALL.ps1"

docker-compose --verbose up --detach $app


