resource "aws_kms_key" "kms" {
  description             = var.kms_key_description
  deletion_window_in_days = 30
  enable_key_rotation     = true
  tags                    = merge(var.tags, { Name = "${var.kms_alias_name}-key" })
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${var.kms_alias_name}"
  target_key_id = aws_kms_key.kms.key_id
}

resource "aws_secretsmanager_secret" "secrets" {
  for_each                = var.secrets
  name                    = each.key
  description             = lookup(each.value, "description", null)
  kms_key_id              = aws_kms_key.kms.arn
  recovery_window_in_days = lookup(each.value, "recovery_window_in_days", 30)
  tags                    = merge(var.tags, { Name = each.key })
}

resource "aws_secretsmanager_secret_version" "versions" {
  for_each      = { for k, v in var.secrets : k => v if lookup(v, "secret_string", null) != null }
  secret_id     = aws_secretsmanager_secret.secrets[each.key].id
  secret_string = each.value.secret_string
}

resource "aws_ssm_parameter" "params" {
  for_each = var.ssm_parameters
  name     = each.key
  type     = lookup(each.value, "type", "SecureString")
  value    = each.value.value
  key_id   = lookup(each.value, "type", "SecureString") == "SecureString" ? aws_kms_key.kms.arn : null
  tags     = merge(var.tags, { Name = each.key })
}
