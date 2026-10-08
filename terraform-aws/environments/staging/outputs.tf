output "vpc_id" {
  description = "VPC ID."
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "Subnet IDs."
  value       = { for k, s in module.subnet.subnets : k => s.id }
}

output "security_group_id" {
  description = "Security Group ID."
  value       = module.security_group.security_group_id
}

output "kms_key_arn" {
  description = "KMS Key ARN."
  value       = module.kms_secrets.kms_key_arn
}

output "s3_bucket_arn" {
  description = "S3 Bucket ARN."
  value       = module.s3.bucket_arn
}

output "ec2_instance_ids" {
  description = "Map of EC2 Instance IDs."
  value       = { for k, e in module.ec2 : k => e.instance_id }
}
