#!/bin/bash
apt update && apt upgrade -y
apt install openssh-server -y
systemctl enable --now ssh
IP="$1"
TOKEN=$(cat /vagrant/node-token)
curl -sfL https://get.k3s.io | K3S_URL="https://192.168.56.11:6443" K3S_TOKEN="$TOKEN" sh -s - agent --node-ip "$IP"
sleep 120
