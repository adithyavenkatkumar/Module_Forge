output "naming_prefix" {
  type        = string
  description = "Standard naming prefix for AWS resources."
  value       = local.naming_prefix
}

output "tags" {
  type        = map(string)
  description = "Merged baseline tags."
  value       = local.standard_tags
}
