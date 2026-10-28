output "instance-ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2_instance.public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance (required for Global Accelerator endpoint_id)"
  value       = module.ec2_instance.id
}

output "instance_arn" {
  description = "ARN of the EC2 instance"
  value       = module.ec2_instance.arn
}

