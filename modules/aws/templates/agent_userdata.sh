#!/bin/bash

export CP_LB_HOST="${cp_lb_host}"
export RKE2_TOKEN="${rke2_token}"

mkdir -p /etc/rancher/k3s

cat << EOF > /etc/rancher/k3s/config.yaml
token: $RKE2_TOKEN
server: https://$CP_LB_HOST:9345
EOF

# curl -sfL https://get.rke2.io | sh -
# curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION=v1.19.16+rke2r1 sh -
# curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION=v1.20.12+rke2r1 sh -
curl -sfL https://get.rke2.io | INSTALL_RKE2_CHANNEL=v1.21 INSTALL_RKE2_TYPE="agent" sh -

systemctl enable rke2-agent
systemctl start rke2-agent

echo "Waiting for rke2 config file to exist.."
while [[ ! -f /etc/rancher/rke2/rke2.yaml ]]; do
  sleep 2
done
