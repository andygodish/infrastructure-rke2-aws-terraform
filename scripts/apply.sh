#!/bin/bash

# Needs to match: *****
rm ./lab/playbooks/inventory/hosts.ini
rm ./lab/playbooks/inventory/group_vars/all.yml

terraform apply -var-file=terraform.tfvars --auto-approve

#                 *****
mv hosts.ini ./lab/playbooks/inventory/hosts.ini
mv all.yml ./lab/playbooks/inventory/group_vars/all.yml