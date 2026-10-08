resource "aws_iam_role" "roles" {
  for_each           = var.roles
  name               = each.key
  assume_role_policy = each.value.assume_role_policy
  tags               = merge(var.tags, { Name = each.key })
}

resource "aws_iam_policy" "policies" {
  for_each    = var.custom_policies
  name        = each.key
  description = lookup(each.value, "description", null)
  policy      = each.value.policy
  tags        = merge(var.tags, { Name = each.key })
}

locals {
  role_attachments = flatten([
    for r_key, r_val in var.roles : [
      for p_arn in lookup(r_val, "policy_arns", []) : {
        key        = "${r_key}-${md5(p_arn)}"
        role_name  = r_key
        policy_arn = p_arn
      }
    ]
  ])
}

resource "aws_iam_role_policy_attachment" "attachments" {
  for_each   = { for a in local.role_attachments : a.key => a }
  role       = aws_iam_role.roles[each.value.role_name].name
  policy_arn = each.value.policy_arn
}

resource "aws_iam_instance_profile" "profiles" {
  for_each = { for k, v in var.roles : k => v if lookup(v, "create_instance_profile", false) }
  name     = "${each.key}-profile"
  role     = aws_iam_role.roles[each.key].name
  tags     = var.tags
}
