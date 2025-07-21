If (-Not(Test-Path variable:path))
{
    'Not Declared path'
    $appPath = $PSScriptRoot | Split-Path | Split-Path
    $appPath
}

Set-Location $appPath
