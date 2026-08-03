#!/bin/bash
apt update && apt upgrade -y
apt install openssh-server -y
systemctl enable --now ssh
curl -sfL https://get.k3s.io | sh -
sleep 120
cd /vagrant/
sudo kubectl apply -f deployment-nginx.yaml
sleep 60
sudo kubectl apply -f service.yaml
