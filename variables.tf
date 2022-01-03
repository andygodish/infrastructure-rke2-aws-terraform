variable "amis" {
  description = "List of amis and default users by region"
  type = map(map(object({
    ami  = string
    user = string
  })))
  default = {
    "us-east-1" = {
      "ubuntu20" = {
        ami  = "ami-0ac80df6eff0e70b5"
        user = "ubuntu"
      }
    }
    "us-gov-west-1" = {
      "rhel8" = {
        ami  = "ami-0ac4e06a69870e5be"
        user = "ec2-user"
      }
      "rhel7" = {
        ami  = "ami-e9d5ec88"
        user = "ec2-user"
      }
      "sles15sp2" = {
        ami  = "ami-04e3d865"
        user = "ec2-user"
      }
      "ubuntu20" = {
        ami  = "ami-84556de5"
        user = "ubuntu"
      }
      "ubuntu18" = {
        ami  = "ami-bce9d3dd"
        user = "ubuntu"
      }
      "centos8" = {
        ami  = "ami-967158f7"
        user = "centos"
      }
      "centos7" = {
        ami  = "ami-bbba86da"
        user = "centos"
      }
      "rocky8" = {
        ami  = "ami-06370d1e5ddbf1f76"
        user = "ec2-user"
      }
    }
  }
}

variable "cluster_name" {
  type = string
  default = "k3s-cluster"
}

variable "is_public" {
    type = bool
}

variable "os" {
  type        = string
  description = "AWS AMI OS"
}

variable "public_ssh_key" {
  type = string
}

variable "rke2_agent_count" {
  type = number
}

variable "region" {
  type    = string
}

variable "tfuser"{
  type = string
  default = "andyg"
}
