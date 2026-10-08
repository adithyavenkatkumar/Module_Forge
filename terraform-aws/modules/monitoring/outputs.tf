output "log_group_arn" {
  type        = string
  description = "CloudWatch Log Group ARN."
  value       = aws_cloudwatch_log_group.logs.arn
}

output "sns_topic_arn" {
  type        = string
  description = "SNS Alert Topic ARN."
  value       = length(aws_sns_topic.alerts) > 0 ? aws_sns_topic.alerts[0].arn : null
}

output "cloudtrail_arn" {
  type        = string
  description = "CloudTrail ARN."
  value       = length(aws_cloudtrail.trail) > 0 ? aws_cloudtrail.trail[0].arn : null
}
