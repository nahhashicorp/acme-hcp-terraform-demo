output "instance_id" {
  value       = module.app_server.instance_id
  description = "EC2 instance ID"
}

output "private_ip" {
  value       = module.app_server.private_ip
  description = "Private IP address"
}

output "security_group_id" {
  value       = module.app_server.security_group_id
  description = "Security group ID"
}
