output "instance-ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "instance_arn" {
  value = aws_instance.ec2_instance.arn
}
