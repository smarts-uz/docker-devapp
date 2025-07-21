$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

docker rmi asrorz_mariadb

Start-Sleep -Seconds 4






