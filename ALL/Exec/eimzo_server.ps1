$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$app = 'eimzo'




docker exec -i $app java -jar /var/app/server/dsv-server.jar -p 9090 -l 0.0.0.0
