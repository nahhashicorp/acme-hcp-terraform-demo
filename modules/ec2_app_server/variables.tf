variable "name_prefix" { type = string }
default = null

variable "environment" { type = string }
default = null

variable "vpc_id"    { type = string }
default = null

variable "subnet_id" { type = string }
default = null

variable "allowed_ssh_cidr" { type = string }
default = null

variable "instance_type" { type = string }
default = null

variable "ami_id"        { type = string }
default = null

variable "tags" {
  type    = map(string)
  default = {}
}
