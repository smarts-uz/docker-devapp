#!/sbin/openrc-run

apk add --no-cache fcgi

curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

curl -sSLf -o /usr/local/bin/install-php-extensions \
https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions

chmod +x /usr/local/bin/install-php-extensions

install-php-extensions pdo_mysql mysqli pdo_pgsql pgsql
install-php-extensions redis zip http gd exif
