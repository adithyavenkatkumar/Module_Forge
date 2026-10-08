output "roles" {
  type = map(object({
    id   = string
    arn  = string
    name = string
  }))
  description = "Map of IAM Roles."
  value = {
    for k, r in aws_iam_role.roles : k => {
      id   = r.id
      arn  = r.arn
      name = r.name
    }
  }
}

output "instance_profiles" {
  type        = map(string)
  description = "Map of Instance Profile Names."
  value       = { for k, p in aws_iam_instance_profile.profiles : k => p.name }
}
