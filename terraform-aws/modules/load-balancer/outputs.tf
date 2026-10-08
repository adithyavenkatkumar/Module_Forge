output "lb_id" {
  type        = string
  description = "Load Balancer ID."
  value       = aws_lb.lb.id
}

output "lb_arn" {
  type        = string
  description = "Load Balancer ARN."
  value       = aws_lb.lb.arn
}

output "dns_name" {
  type        = string
  description = "Load Balancer DNS Name."
  value       = aws_lb.lb.dns_name
}

output "target_group_arns" {
  type        = map(string)
  description = "Map of Target Group ARNs."
  value       = { for k, tg in aws_lb_target_group.tg : k => tg.arn }
}
