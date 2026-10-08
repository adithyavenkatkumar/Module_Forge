output "db_instance_id" {
  type        = string
  description = "RDS Instance ID."
  value       = aws_db_instance.db.id
}

output "db_instance_endpoint" {
  type        = string
  description = "RDS Connection Endpoint."
  value       = aws_db_instance.db.endpoint
}

output "db_instance_arn" {
  type        = string
  description = "RDS Instance ARN."
  value       = aws_db_instance.db.arn
}

output "master_user_secret_arn" {
  type        = string
  description = "Master User Secret ARN in Secrets Manager."
  value       = length(aws_db_instance.db.master_user_secret) > 0 ? aws_db_instance.db.master_user_secret[0].secret_arn : null
}
