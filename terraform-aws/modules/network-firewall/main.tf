resource "aws_networkfirewall_rule_group" "rules" {
  capacity = 100
  name     = "${var.name}-rule-group"
  type     = "STATELESS"

  rule_group {
    rules_source {
      stateless_rules_and_custom_actions {
        stateless_rule {
          priority = 1
          rule_definition {
            actions = ["aws:pass"]
            match_attributes {
              source {
                address_definition = "0.0.0.0/0"
              }
            }
          }
        }
      }
    }
  }
  tags = merge(var.tags, { Name = "${var.name}-rule-group" })
}

resource "aws_networkfirewall_firewall_policy" "policy" {
  name = "${var.name}-policy"

  firewall_policy {
    stateless_default_actions          = ["aws:pass"]
    stateless_fragment_default_actions = ["aws:pass"]

    stateless_rule_group_reference {
      priority     = 1
      resource_arn = aws_networkfirewall_rule_group.rules.arn
    }
  }

  tags = merge(var.tags, { Name = "${var.name}-policy" })
}

resource "aws_networkfirewall_firewall" "nfw" {
  name                = var.name
  firewall_policy_arn = aws_networkfirewall_firewall_policy.policy.arn
  vpc_id              = var.vpc_id

  dynamic "subnet_mapping" {
    for_each = var.subnet_ids
    content {
      subnet_id = subnet_mapping.value
    }
  }

  tags = merge(var.tags, { Name = var.name })
}
