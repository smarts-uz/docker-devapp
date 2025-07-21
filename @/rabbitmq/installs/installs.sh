#!/bin/bash

apt-get -yqq update && \
    apt-get -y install mc nano wget htop nmap telnet net-tools

apt-get -y install ssh systemd openssh-server

# Setup sshd environement

mkdir -p /var/run/sshd
chmod 755 /var/run/sshd

sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

# Delete root password (set as empty)
passwd -d root

sed -ri 's/PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
sed -ri 's/#PermitEmptyPasswords yes/PermitEmptyPasswords yes/' /etc/ssh/sshd_config


sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
