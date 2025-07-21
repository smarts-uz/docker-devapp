$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$appsStr = $(docker images -a -q)
Write-Output $appsStr

If (-Not $null -eq $appsStr)
{
    docker stop $appsStr_1
    docker rm -f $appsStr_1

    docker rmi $appsStr
    docker volume rm $appsStr
}
Else
{
    "Are Empty"
}
Start-Sleep -Seconds 4






