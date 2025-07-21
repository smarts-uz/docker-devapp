$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

. "$root/ALL/App/List.ps1"

ForEach ($app In $apps)
{
    . "$root/ALL/Up-Compose/Azk.ps1"
}

