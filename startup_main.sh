#!/bin/bash
apt update && apt upgrade -y
apt install openssh-server -y
systemctl enable --now ssh
curl -sfL https://get.k3s.io | sh -s - server --cluster-init --tls-san 192.168.56.11 --node-ip 192.168.56.11 --flannel-iface enp0s8
sleep 20
sudo cat /var/lib/rancher/k3s/server/node-token >/vagrant/node-token
cd /vagrant/
sudo kubectl taint nodes k3s-server-1 CriticalAddonsOnly=true:NoExecute
