$apps = @(
    'git',
    'eimzo',
    'mariadb',
    # 'mongo',
    # 'mysql',
    'netdata',
    'nginx',
    'php',
    'portainer',
    'postgres',
    # 'rabbitmq',
    'redis'
);
Get-Variable "apps"

$appsStr = $apps -Join " "
Get-Variable "appsStr"



