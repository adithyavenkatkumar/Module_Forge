output "vpc_id" {
  type        = string
  description = "VPC ID."
  value       = aws_vpc.vpc.id
}

output "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR Block."
  value       = aws_vpc.vpc.cidr_block
}

output "internet_gateway_id" {
  type        = string
  description = "Internet Gateway ID."
  value       = length(aws_internet_gateway.igw) > 0 ? aws_internet_gateway.igw[0].id : null
}
