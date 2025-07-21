#!/bin/bash

# Install

apt-get -yqq update
apt-get -y install ssh mc openssh-server sudo


# MKDIR

mkdir -p /var/run/sshd
chmod 755 /var/run/sshd



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

