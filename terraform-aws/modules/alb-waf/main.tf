resource "aws_wafv2_web_acl" "waf" {
  name        = "${var.name}-waf"
  description = "WAFv2 Web ACL for ${var.name}"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.name}-waf-metric"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "CommonRuleSetMetric"
      sampled_requests_enabled   = true
    }
  }

  tags = merge(var.tags, { Name = "${var.name}-waf" })
}

module "alb" {
  source          = "../load-balancer"
  name            = var.name
  vpc_id          = var.vpc_id
  subnets         = var.subnets
  security_groups = var.security_groups
  target_groups   = var.target_groups
  listeners       = var.listeners
  tags            = var.tags
}

resource "aws_wafv2_web_acl_association" "alb_assoc" {
  resource_arn = module.alb.lb_arn
  web_acl_arn  = aws_wafv2_web_acl.waf.arn
}
