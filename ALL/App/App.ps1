. "$root/ALL/App/Init.ps1"

$appFull = "$($Env:COMPOSE_PROJECT_NAME)_$($app)"
Get-Variable "appFull"

$appImageFull = "$($Env:COMPOSE_PROJECT_NAME)-$($app)"
Get-Variable "appImageFull"
