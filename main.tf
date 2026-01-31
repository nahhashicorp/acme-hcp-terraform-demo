provider "aws" {
  region = var.aws_region
}

module "app_server" {
  source = "./modules/ec2_app_server"

  name_prefix      = var.name_prefix
  environment      = var.environment
  vpc_id           = var.vpc_id
  subnet_id        = var.subnet_id
  allowed_ssh_cidr = var.allowed_ssh_cidr

  # Demo knobs (change these in PR)
  instance_type    = var.instance_type
  ami_id           = var.ami_id

  tags             = var.tags
}
