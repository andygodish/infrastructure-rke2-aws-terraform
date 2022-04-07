# infrastructure-rke2-aws-terraform

Terraform script designed to quickly stand up a RKE2 cluster.

First iteration creates a single vpc with two public subnets.

## Quick Commands

# terraform

terraform apply -var-file=terraform.tfvars --auto-approve
terraform destroy -var-file=terraform.tfvars --auto-approve


# rke2 configuration

export PATH=/var/lib/rancher/rke2/bin:$PATH
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
alias k=kubectl


# retrieve kubeconfig

scp rke2-init-server:/tmp/rke2.yaml ~/.kube/infrastructure-rke2-aws-terrraform-config
export KUBECONFIG=~/.kube/infrastructure-rke2-aws-terrraform-config


# etcdctl commands

etcdctl --cacert=/var/lib/rancher/rke2/server/tls/etcd/server-ca.crt --cert=/var/lib/rancher/rke2/server/tls/etcd/server-client.crt --key=/var/lib/rancher/rke2/server/tls/etcd/server-client.key member list

## This does not work 1:1 from the docker command used in RKE1 clusters, below is the step-by-step breakdown of those commands 

crictl --config /var/lib/rancher/rke2/agent/etc/crictl.yaml exec -e ETCDCTL_ENDPOINTS=$(crictl --config /var/lib/rancher/rke2/agent/etc/crictl.yaml exec 3b8554d8909f1 /bin/sh -c "etcdctl --cacert=/var/lib/rancher/rke2/server/tls/etcd/server-ca.crt --cert=/var/lib/rancher/rke2/server/tls/etcd/server-client.crt --key=/var/lib/rancher/rke2/server/tls/etcd/server-client.key member list | cut -d, -f5 | sed -e 's/ //g' | paste -sd ','") 3b8554d8909f1 etcdctl endpoint health

---

export ETCDCTL_ENDPOINTS=$(etcdctl --cacert=/var/lib/rancher/rke2/server/tls/etcd/server-ca.crt --cert=/var/lib/rancher/rke2/server/tls/etcd/server-client.crt --key=/var/lib/rancher/rke2/server/tls/etcd/server-client.key member list | cut -d, -f5 | sed -e 's/ //g' | paste -sd ',')

etcdctl --cacert=/var/lib/rancher/rke2/server/tls/etcd/server-ca.crt --cert=/var/lib/rancher/rke2/server/tls/etcd/server-client.crt --key=/var/lib/rancher/rke2/server/tls/etcd/server-client.key endpoint health

etcdctl --cacert=/var/lib/rancher/rke2/server/tls/etcd/server-ca.crt --cert=/var/lib/rancher/rke2/server/tls/etcd/server-client.crt --key=/var/lib/rancher/rke2/server/tls/etcd/server-client.key endpoint status --cluster -w table
