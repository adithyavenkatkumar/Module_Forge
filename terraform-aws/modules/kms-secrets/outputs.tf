output "kms_key_id" {
  type        = string
  description = "KMS Key ID."
  value       = aws_kms_key.kms.key_id
}

output "kms_key_arn" {
  type        = string
  description = "KMS Key ARN."
  value       = aws_kms_key.kms.arn
}

output "kms_alias_arn" {
  type        = string
  description = "KMS Alias ARN."
  value       = aws_kms_alias.alias.arn
}

output "secrets" {
  type        = map(string)
  description = "Secrets Manager secret ARNs."
  value       = { for k, s in aws_secretsmanager_secret.secrets : k => s.arn }
}

output "ssm_parameters" {
  type        = map(string)
  description = "SSM parameter ARNs."
  value       = { for k, p in aws_ssm_parameter.params : k => p.arn }
}
