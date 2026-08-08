#!/bin/bash
apt update && apt upgrade -y
apt install openssh-server -y
systemctl enable --now ssh
IP="$1"
NAME="$2"
TOKEN=$(cat /vagrant/node-token)
curl -sfL https://get.k3s.io | K3S_TOKEN="$TOKEN" sh -s - server --server https://192.168.56.11:6443 --tls-san "$IP" --node-ip "$IP" --flannel-iface enp0s8
sleep 20
sudo kubectl taint nodes "$NAME" CriticalAddonsOnly=true:NoExecute
