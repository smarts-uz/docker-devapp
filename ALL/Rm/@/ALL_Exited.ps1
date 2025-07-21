$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

$appsStr = $(docker ps -a -f status=exited -q)
Write-Output $appsStr

If (-Not $null -eq $appsStr)
{
    docker rm -f $appsStr
}
Else
{
    "Are Empty"
}

Start-Sleep -Seconds 4




