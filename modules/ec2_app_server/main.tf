locals {
  name = "${var.name_prefix}-${var.environment}"

  merged_tags = merge(var.tags, {
    Name        = local.name
    Environment = var.environment
  })
}

resource "aws_security_group" "app_sg" {
  count       = var.create_security_group ? 1 : 0
  name        = "${local.name}-sg"
  description = "Demo SG for ${local.name}"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH (demo only)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.merged_tags
}

data "aws_security_group" "existing" {
  count = var.create_security_group ? 0 : 1
  id    = var.existing_security_group_id
}

locals {
  security_group_id = try(aws_security_group.app_sg[0].id, data.aws_security_group.existing[0].id)
}

resource "aws_instance" "app" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [local.security_group_id]
  associate_public_ip_address = false

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = local.merged_tags
}
