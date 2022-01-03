module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "${var.tfuser}-keypair-${random_string.random_append.result}"
  public_key = var.public_ssh_key
}

resource "random_string" "rke2_token" {
  length  = 20
  special = false
}

# Random string appended to the name of most 
# resources that negates name conflicts in AWS
resource "random_string" "random_append" {
  length  = 6
  special = false
}
