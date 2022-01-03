
variable "amis" {
  type = map(map(object({
    ami  = string
    user = string
  })))
}

variable "cidr_public_subnet_1" {
  type    = string
  default = "10.0.11.0/24"
}

variable "cidr_public_subnet_2" {
  type    = string
  default = "10.0.12.0/24"
}

variable "cidr_vpc" {
  type    = string
  default = "10.0.0.0/16"
}

variable "cluster_name" {
  type = string
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
variable "rke2_agent_size" {
  type    = string
  default = "t2.xlarge"
}
variable "rke2_server_size" {
  type    = string
  default = "t2.xlarge"
}

variable "region" {
  type    = string
}

variable "tfuser"{
  type = string
}
