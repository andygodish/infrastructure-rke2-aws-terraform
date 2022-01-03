#######
# VPC #
#######

resource "aws_vpc" "rke2_vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name                                        = "rke2 VPC-${var.tfuser}"
    Owner                                       = var.tfuser
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

###########
# SUBNETS #
###########

data "aws_availability_zones" "available_azs" {
  state = "available"
}

resource "aws_subnet" "rke2_public_subnet_1" {
  vpc_id            = aws_vpc.rke2_vpc.id
  availability_zone = data.aws_availability_zones.available_azs.names[0]
  cidr_block        = var.cidr_public_subnet_1

  tags = {
    Name                                        = "rke2 Public Subnet 1-${var.tfuser}"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "KubernetesCluster"                         = var.cluster_name
    "kubernetes.io/role/elb"                    = ""
    Owner                                       = var.tfuser
  }
}

resource "aws_subnet" "rke2_public_subnet_2" {
  vpc_id            = aws_vpc.rke2_vpc.id
  availability_zone = data.aws_availability_zones.available_azs.names[1]
  cidr_block        = var.cidr_public_subnet_2

  tags = {
    Name                                        = "rke2 Public Subnet 2-${var.tfuser}"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "KubernetesCluster"                         = var.cluster_name
    "kubernetes.io/role/elb"                    = ""
    Owner                                       = var.tfuser
  }
}

############
# GATEWAYS #
############

resource "aws_internet_gateway" "rke2_igw" {
  vpc_id = aws_vpc.rke2_vpc.id

  tags = {
    Name  = "rke2 IGW-${var.tfuser}"
    Owner = var.tfuser
  }
}

################
# ROUTE TABLES #
################

resource "aws_route_table" "rke2_public_rt" {
  vpc_id = aws_vpc.rke2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rke2_igw.id
  }

  tags = {
    Name = "rke2 Public Route Table-${var.tfuser}"
    Owner = var.tfuser
  }
}

resource "aws_route_table_association" "rke2_public_rt_assoc_1" {
  subnet_id      = aws_subnet.rke2_public_subnet_1.id
  route_table_id = aws_route_table.rke2_public_rt.id
}

resource "aws_route_table_association" "rke2_public_rt_assoc_2" {
  subnet_id      = aws_subnet.rke2_public_subnet_2.id
  route_table_id = aws_route_table.rke2_public_rt.id
}
