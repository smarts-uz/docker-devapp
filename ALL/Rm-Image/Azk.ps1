"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
. "$root/ALL/App/ALL.ps1"

. "$root/ALL/App/App.ps1"


docker image rm --force $appImageFull

