output "instance_id" {
  type        = string
  description = "EC2 Instance ID."
  value       = aws_instance.ec2.id
}

output "arn" {
  type        = string
  description = "EC2 Instance ARN."
  value       = aws_instance.ec2.arn
}

output "private_ip" {
  type        = string
  description = "Private IP address."
  value       = aws_instance.ec2.private_ip
}

output "public_ip" {
  type        = string
  description = "Public IP address."
  value       = aws_instance.ec2.public_ip
}
