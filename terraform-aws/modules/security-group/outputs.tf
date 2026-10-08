output "security_group_id" {
  type        = string
  description = "Security Group ID."
  value       = aws_security_group.sg.id
}

output "security_group_arn" {
  type        = string
  description = "Security Group ARN."
  value       = aws_security_group.sg.arn
}

output "security_group_name" {
  type        = string
  description = "Security Group Name."
  value       = aws_security_group.sg.name
}
