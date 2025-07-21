$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"



docker-compose --verbose up -d php nginx postgres redis portainer
pause


