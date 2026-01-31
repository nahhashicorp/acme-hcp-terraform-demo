locals {
  name = "${var.name_prefix}-${var.environment}"

  merged_tags = merge(var.tags, {
    Name        = local.name
    Environment = var.environment
  })
}

resource "aws_security_group" "app_sg" {
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

resource "aws_instance" "app" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  associate_public_ip_address = false

  # Security best practice defaults (nice talking points)
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required" # IMDSv2
  }

  tags = local.merged_tags
}
