variable "aws_region" {
  type        = string
  description = "AWS region to deploy into"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Environment name (dev|prod)"
  default     = "dev"
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "environment must be dev or prod."
  }
}

variable "name_prefix" {
  type        = string
  description = "Resource name prefix"
  default     = "acme-app"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "CIDR allowed to SSH (demo only — real world: prefer SSM/Boundary)"
  default     = "10.0.0.0/8"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type (best demo knob)"
  default     = "t3.large"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the app server image"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default = {
    Owner      = "platform"
    CostCenter = "RND-1001"
    ManagedBy  = "HCP-Terraform"
  }
}
