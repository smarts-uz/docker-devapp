#!/sbin/openrc-run


# Install

apk update

apk add --no-cache openssl tini openssh mc fping
apk add --no-cache wget nmap net-tools curl
apk add --no-cache busybox-extras busybox-initscripts
apk add --no-cache openrc bash sudo su-exec grep htop
apk add --no-cache ne tilde emacs nano
apk add --no-cache python3 py3-pip unzip gzip


# MKDIR

mkdir -p /run/openrc
touch /run/openrc/softlevel



# Configs

mkdir -p /var/run/sshd
chmod 755 /var/run/sshd

ssh-keygen -A
rc-update add sshd default



# SED

sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config



# Print Environment

echo "Print Environment"
printenv



# Root Pass

echo "Changing Root Password"
echo ${ROOT_PASSWORD}
echo "root:${ROOT_PASSWORD}" | chpasswd
