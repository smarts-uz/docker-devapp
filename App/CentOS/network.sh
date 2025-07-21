#!/bin/bash


##########  ip link  #########
ip link set dev ens33 mtu 900


##########  ipv4.ip_forward  #########

echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf

sysctl -p
sysctl net.ipv4.ip_forward



##########  Nameserver  #########

echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
echo 'nameserver 8.8.4.4' >> /etc/resolv.conf

systemctl daemon-reload



##########  Docker  #########

systemctl restart docker
systemctl restart network
reboot
