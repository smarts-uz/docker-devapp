
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
. "$root/ALL/App/ALL.ps1"
. "$root/ALL/App/App.ps1"

docker volume rm --force $appFull
