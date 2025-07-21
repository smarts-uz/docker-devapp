$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"


If (-Not(Test-Path variable:app))
{
    $app = 'php'
}



"LN -S Storage for:|" + $appPath + "|"


$run = "rm -f $appPath/public/storage"
$run
docker-compose exec -T $app bash -c $run

$run = "ln -s $appPath/storage/var/app/public $appPath/public/storage"
$run
docker-compose exec -T $app bash -c $run

