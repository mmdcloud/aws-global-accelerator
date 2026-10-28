output "global_accelerator_dns" {
  description = "DNS name of the Global Accelerator"
  value       = aws_globalaccelerator_accelerator.ga.dns_name
}

output "global_accelerator_ips" {
  description = "Static anycast IP addresses of the Global Accelerator"
  value       = aws_globalaccelerator_accelerator.ga.ip_sets[0].ip_addresses
}

output "nv_instance_ip" {
  description = "North Virginia EC2 instance public IP"
  value       = module.nv-resources.instance-ip
}

output "mumbai_instance_ip" {
  description = "Mumbai EC2 instance public IP"
  value       = module.mumbai-resources.instance-ip
}

