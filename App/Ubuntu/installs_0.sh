#!/bin/bash

# Install

apt-get -yqq update

apt-get -y install wget nmap telnet net-tools curl inetutils-ping
apt-get -y install ssh mc openssh-server sudo
apt-get -y install systemd systemd-services htop
apt-get -y install ne tilde emacs nano apt-file apt-utils
apt-get -y install python3 python3-pip unzip


# MKDIR

mkdir -p /var/run/sshd
chmod 755 /var/run/sshd


# tzdata

ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone
apt-get update && apt-get install -y tzdata



# SED

sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd



# Root Pass

echo ${ROOT_PASSWORD}
echo "root:${ROOT_PASSWORD}" | chpasswd

