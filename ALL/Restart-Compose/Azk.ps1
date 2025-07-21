


Set-Location $root

'Going to Restart :'
Get-Variable "app"

docker-compose restart $app

. "$root/ALL/Exec_Sshd/Azk.ps1"


