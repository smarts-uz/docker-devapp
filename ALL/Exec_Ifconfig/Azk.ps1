"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
. "$root/ALL/App/ALL.ps1"

docker exec -i $app ifconfig
docker exec -i $app ip addr show
