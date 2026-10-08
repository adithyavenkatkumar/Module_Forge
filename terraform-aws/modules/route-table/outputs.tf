output "route_table_id" {
  type        = string
  description = "Route Table ID."
  value       = aws_route_table.rt.id
}

output "route_table_arn" {
  type        = string
  description = "Route Table ARN."
  value       = aws_route_table.rt.arn
}
