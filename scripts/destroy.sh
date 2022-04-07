#!/bin/bash

# TODO: Find and delete any loadbalancers associated with your VPC, you may need to delete an associated security group that was created for the LB as well.

terraform destroy -var-file=terraform.tfvars --auto-approve

