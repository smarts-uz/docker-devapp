#!/bin/bash

##########  Core  #########

yum -y update

yum -y install nmap wget nano net-tools
yum -y install epel-release htop sudo yum-utils
yum -y install mc unzip gzip git
yum -y install openssh-server telnet-server telnet
yum -y install device-mapper-persistent-data lvm2
yum -y install python-pip python3-pip p7zip
yum -y install ntp ntpdate ntp-doc




##########  NTP  #########

chkconfig ntpd on

ntpdate pool.ntp.org
echo '0.rhel.pool.ntp.org' >> /etc/ntp.conf
echo '1.rhel.pool.ntp.org' >> /etc/ntp.conf
echo '2.rhel.pool.ntp.org' >> /etc/ntp.conf

systemctl start ntpd
systemctl enable ntpd
systemctl status ntpd

ntpdate -u -s 0.centos.pool.ntp.org 1.centos.pool.ntp.org 2.centos.pool.ntp.org
systemctl restart ntpd

timedatectl

hwclock  -w
hwclock --show --verbose


##########  Busybox  #########

wget https://busybox.net/downloads/binaries/1.28.1-defconfig-multiarch/busybox-x86_64
mv busybox-x86_64 busybox
chmod +x busybox
./busybox



##########  Powershell  #########

curl https://packages.microsoft.com/config/rhel/7/prod.repo | tee /etc/yum.repos.d/microsoft.repo
yum -y update
yum -y install powershell



##########  Docker Engine  #########

yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine




##########  Docker Engine  #########

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin

systemctl start docker




########## Remove Docker Compose  #########

yum remove docker-compose-plugin
rm $DOCKER_CONFIG/cli-plugins/docker-compose
rm /usr/local/lib/docker/cli-plugins/docker-compose
rm /usr/libexec/docker/cli-plugins/docker-compose

docker info --format '{{range .ClientInfo.Plugins}}{{if eq .Name "compose"}}{{.Path}}{{end}}{{end}}'




##########  Docker Compose  #########

DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}

mkdir -p $DOCKER_CONFIG/cli-plugins

curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
