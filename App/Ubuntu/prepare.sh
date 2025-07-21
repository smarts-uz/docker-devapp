#!/bin/bash

############################ Ulug'bek ###############################

######### Install ####################################

apt-get -y update
apt-get -y install wget net-tools mc
apt-get -y install htop zip unzip p7zip-full p7zip-rar
apt-get -y install systemd git nmap
apt-get -y install apt-file lvm2 telnetd
apt-get -y install python3 python3-pip busybox 

######### powershell ##################################

apt-get -y install wget apt-transport-https software-properties-common
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
dpkg -i packages-microsoft-prod.deb
apt-get -y update
apt-get -y install powershell

######### docker engine ###############################

apt-get -y update
apt-get -y install docker.io

######### docker compose ##############################

apt-get -y install docker-compose
