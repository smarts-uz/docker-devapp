$root = $PSScriptRoot | Split-Path | Split-Path
Set-Location $root
"$($PSScriptRoot) | $($MyInvocation.MyCommand.Name)"

Write-Output "Root: $($root)"
Write-Output "Args: $($args)"
Write-Output "Args Count: $($args.count)"
Write-Output  "$IsLinux"
if ($args.count -lt 3)
{
    Write-Output 'Incorrect Argument count'
    exit
}



$folder = $args[0]
$file = $args[1]
$run = $args[2]


If ($IsLinux) {
    pwsh -File "/var/app/ALL/ALL/$($folder)/$($file).ps1" "$*" -All
}
else
{
    Powershell.exe -ExecutionPolicy ByPass -File "D:\Develop\Projects\docker\ALL\ALL\$($folder)\$($file).ps1" %*
}








. "$root/ALL/$($folder)/$($file).ps1"

switch -Exact ($folder)
{

    #region ALL

    'all-all' {
        . "$root/ALL/ALL/ALL.ps1"
        Break
    }

    'all-php' {
        . "$root/ALL/ALL/php.ps1"
        Break
    }

    'all-mariadb' {
        . "$root/ALL/ALL/mariadb.ps1"
        Break
    }

    'all-postgres' {
        . "$root/ALL/ALL/postgres.ps1"
        Break
    }

    'all-nginx' {
        . "$root/ALL/ALL/nginx.ps1"
        Break
    }

    #endregion

    #region All-Nc

    'all-nc-all' {
        . "$root/ALL/ALL-Nc/ALL.ps1"
        Break
    }


    #endregion

    #region All-Up

    'all-up-all' {
        . "$root/ALL/ALL-Up/ALL.ps1"
        Break
    }

    'all-up-eimzo' {
        . "$root/ALL/ALL-Up/eimzo.ps1"
        Break
    }

    'all-up-git' {
        . "$root/ALL/ALL-Up/git.ps1"
        Break
    }
    'all-up-mariadb' {
        . "$root/ALL/ALL-Up/mariadb.ps1"
        Break
    }

    'all-up-mongo' {
        . "$root/ALL/ALL-Up/mongo.ps1"
        Break
    }

    'all-up-mysql' {
        . "$root/ALL/ALL-Up/mysql.ps1"
        Break
    }

    'all-up-netdata' {
        . "$root/ALL/ALL-Up/netdata.ps1"
        Break
    }

    'all-up-nginx' {
        . "$root/ALL/ALL-Up/nginx.ps1"
        Break
    }
    'all-up-php' {
        . "$root/ALL/ALL-Up/nginx.ps1"
        Break
    }

    'all-up-portainer' {
        . "$root/ALL/ALL-Up/portainer.ps1"
        Break
    }
    'all-up-postgres' {
        . "$root/ALL/ALL-Up/postgres.ps1"
        Break
    }

    'all-up-ubuntu' {
        . "$root/ALL/ALL-Up/ubuntu.ps1"
        Break
    }

    'all-up-rabbitmq' {
        . "$root/ALL/ALL-Up/rabbitmq.ps1"
        Break
    }

    'all-up-redis' {
        . "$root/ALL/ALL-Up/redis.ps1"
        Break
    }
    #endregion



    #region extract

    'extract-docker' {
        . "$root/ALL/Unzip/docker.ps1"
        Break
    }

    #endregion


    #region artisan

    'artisan-app-storage-link' {
        . "$root/ALL/Artisan/storage-link.ps1"
        Break
    }
    'artisan-app-websocket-serve' {
        . "$root/ALL/Artisan/websocket-serve.ps1"
        Break
    }

    'artisan-php-storage-link' {
        . "$root/ALL/Artisan/php storage-link.ps1"
        Break
    }

    #endregion

    #region LN

    'LN-app-symlink-storage' {
        . "$root/ALL/LN/App/symlink-storage.ps1"
        Break
    }

    'LN-nginx-storage-link' {
        . "$root/ALL/LN/nginx storage-link.ps1"
        Break
    }


    #endregion

    #region chmod

    'chmod-all' {
        . "$root/ALL/Chmod/ALL.ps1"
        Break
    }

    'chmod-laravel' {
        . "$root/ALL/Chmod/laravel.ps1"
        Break
    }

    #endregion

    #region composer
    'composer-app-dump-autoload-optimize' {
        . "$root/ALL/Composer/App/dump-autoload --optimize.ps1"
        Break
    }

    'composer-app-dump-autoload' {
        . "$root/ALL/Composer/App/dump-autoload.ps1"
        Break
    }

    'composer-app-outdated-direct' {
        . "$root/ALL/Composer/App/outdated --direct.ps1"
        Break
    }

    'composer-app-show-installed' {
        . "$root/ALL/Composer/App/show --installed.ps1"
        Break
    }

    'composer-app-show-tree' {
        . "$root/ALL/Composer/App/show --tree.ps1"
        Break
    }

    'composer-dump-autoload-optimize' {
        . "$root/ALL/Composer/dump-autoload --optimize.ps1"
        Break
    }

    'composer-dump-autoload' {
        . "$root/ALL/Composer/dump-autoload.ps1"
        Break
    }

    'composer-outdated-direct' {
        . "$root/ALL/Composer/outdated --direct.ps1"
        Break
    }

    'composer-show-installed' {
        . "$root/ALL/Composer/show --installed.ps1"
        Break
    }

    'composer-show-tree' {
        . "$root/ALL/Composer/show --tree.ps1"
        Break
    }

    'composer-install-prefer-dist' {
        . "$root/ALL/Composer/install --prefer-dist.ps1"
        Break
    }

    'composer-install-prefer-dist-ignore-platform-reqs' {
        . "$root/ALL/Composer/install --prefer-dist --ignore-platform-reqs.ps1"
        Break
    }

    'composer-update-prefer-dist-prefer-stable' {
        . "$root/ALL/Composer/update --prefer-dist --prefer-stable.ps1"
        Break
    }

    'composer-update-prefer-dist-prefer-stable-ignore-platform-reqs' {
        . "$root/ALL/Composer/update --prefer-dist --prefer-stable --ignore-platform-reqs.ps1"
        Break
    }

    #endregion

    #region git

    'git-pull' {
        . "$root/ALL/Git/pull.ps1"
        Break
    }

    'git-reset' {
        . "$root/ALL/Git/reset.ps1"
        Break
    }

    'git-reset-pull' {
        . "$root/ALL/Git/reset pull.ps1"
        Break
    }

    'git-stash' {
        . "$root/ALL/Git/stash.ps1"
        Break
    }

    'git-stash-pull' {
        . "$root/ALL/Git/stash pull.ps1"
        Break
    }

    #endregion

    #region Git App

    'git-app-branch' {
        . "$root/ALL/Git/App/branch.ps1"
        Break
    }

    'git-app-pull' {
        . "$root/ALL/Git/App/pull.ps1"
        Break
    }


    'git-app-reset' {
        . "$root/ALL/Git/App/reset.ps1"
        Break
    }
    'git-app-reset-pull' {
        . "$root/ALL/Git/App/reset.ps1"
        . "$root/ALL/Git/App/pull.ps1"
        Break
    }

    'git-app-stash' {
        . "$root/ALL/Git/App/stash.ps1"
        Break
    }
    'git-app-stash-pull' {
        . "$root/ALL/Git/App/stash.ps1"
        . "$root/ALL/Git/App/pull.ps1"
        Break
    }

    #endregion

    #region exec

    'exec-netstat' {
        . "$root/ALL/Exec_Netstat/ALL.ps1"
        Break
    }

    'exec-ifconfig' {
        . "$root/ALL/Exec_Ifconfig/ALL.ps1"
        Break
    }

    'exec-sshd' {
        . "$root/ALL/Exec_Sshd/ALL.ps1"
        Break
    }

    'exec-iclient' {
        . "$root/ALL/Exec-Compose/eimzo client.ps1"
        Break
    }

    'exec-iserver' {
        . "$root/ALL/Exec-Compose/eimzo server.ps1"
        Break
    }

    #endregion

    #region restart

    'restart-eimzo' {
        . "$root/ALL/Restart-Compose/eimzo.ps1"
        Break
    }

    'restart-nginx' {
        . "$root/ALL/Restart-Compose/nginx.ps1"
        Break
    }
    'restart-php' {
        . "$root/ALL/Restart-Compose/php.ps1"
        Break
    }
    'restart-mariadb' {
        . "$root/ALL/Restart-Compose/mariadb.ps1"
        Break
    }

    'restart-portainer' {
        . "$root/ALL/Restart-Compose/portainer.ps1"
        Break
    }

    #endregion


}

$result

