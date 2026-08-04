#!/bin/bash
apt update && apt upgrade -y
apt install openssh-server -y
systemctl enable --now ssh
curl -sfL https://get.k3s.io | sh -s - server --cluster-init --tls-san 192.168.56.11 --node-ip 192.168.56.11
sleep 120
sudo cat /var/lib/rancher/k3s/server/node-token >/vagrant/node-token
