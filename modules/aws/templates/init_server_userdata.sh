#!/bin/bash

# apt-get update -y
# apt-get install -y curl python-pip

export CP_LB_HOST="${cp_lb_host}" # Needed to pick up in heredoc
export RKE2_TOKEN="${rke2_token}"

mkdir -p /etc/rancher/rke2

cat << EOF > /etc/rancher/rke2/config.yaml
write-kubeconfig-mode: 644
cloud-provider-name: aws
token: $RKE2_TOKEN
tls-san:
- $CP_LB_HOST
EOF

# curl -sfL https://get.rke2.io | sh -
# curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION=v1.19.16+rke2r1 sh -
# curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION=v1.20.12+rke2r1 sh -
curl -sfL https://get.rke2.io | INSTALL_RKE2_VERSION=v1.21.7+rke2r2 sh -

systemctl enable rke2-server
systemctl start rke2-server

echo "Waiting for rke2 config file to exist.."
while [[ ! -f /etc/rancher/rke2/rke2.yaml ]]; do
  sleep 2
done

cp /etc/rancher/rke2/rke2.yaml /tmp/rke2.yaml
sed -i -e "s/127.0.0.1/${cp_lb_host}/g" /tmp/rke2.yaml

