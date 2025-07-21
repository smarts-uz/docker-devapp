$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"
$app = 'php'


. "$root/ALL/App/Path.ps1"

If (-Not(Test-Path variable:path))
{
    'Not Declared path'
    $appDockerPath = "$appLinuxPath/example-app"
    $appDockerPath
}

