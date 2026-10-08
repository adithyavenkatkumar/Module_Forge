output "alb_arn" {
  type        = string
  description = "ALB ARN."
  value       = module.alb.lb_arn
}

output "alb_dns_name" {
  type        = string
  description = "ALB DNS Name."
  value       = module.alb.dns_name
}

output "web_acl_arn" {
  type        = string
  description = "WAF Web ACL ARN."
  value       = aws_wafv2_web_acl.waf.arn
}
