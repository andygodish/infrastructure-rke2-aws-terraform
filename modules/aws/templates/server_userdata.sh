#!/bin/bash

# apt-get update -y
# apt-get install -y curl python-pip

export CP_LB_HOST="${cp_lb_host}" # Needed to pick up in heredoc
export RKE2_TOKEN="${rke2_token}"
export SERVER_IP="${server_ip}"

mkdir -p /etc/rancher/rke2

cat << EOF > /etc/rancher/rke2/config.yaml
server: https://$CP_LB_HOST:9345
token: $RKE2_TOKEN
tls-san:
- $CP_LB_HOST
EOF

# curl -sfL https://get.rke2.io | sh -
# curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION=v1.19.16+rke2r1 sh -
# curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION=v1.20.12+rke2r1 sh -
# curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION=v1.21.7+rke2r2 sh -
curl -sfL https://get.rke2.io | INSTALL_RKE2_CHANNEL=v1.18 sh -

sleep 300

systemctl enable rke2-server
systemctl start rke2-server

echo "Waiting for rke2 config file to exist.."
while [[ ! -f /etc/rancher/rke2/rke2.yaml ]]; do
  sleep 2
done
