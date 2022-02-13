# infrastructure-rke2-aws-terraform

Terraform script designed to quickly stand up a RKE2 cluster.

First iteration creates a single vpc with two public subnets.

## Quick Commands

```
# terraform

terraform apply -var-file=terraform.tfvars --auto-approve
terraform destroy -var-file=terraform.tfvars --auto-approve

# rke2 configuration

export PATH=/var/lib/rancher/rke2/bin:$PATH
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
alias k=kubectl

# retrieve kubeconfig

scp rke2-init-server:/tmp/rke2.yaml ~/.kube/infrastructure-rke2-aws-terrraform-config


