output "cluster_id" {
  type        = string
  description = "EKS Cluster ID."
  value       = aws_eks_cluster.eks.id
}

output "cluster_arn" {
  type        = string
  description = "EKS Cluster ARN."
  value       = aws_eks_cluster.eks.arn
}

output "endpoint" {
  type        = string
  description = "EKS Cluster Endpoint."
  value       = aws_eks_cluster.eks.endpoint
}

output "cluster_certificate_authority_data" {
  type        = string
  description = "Certificate Authority Data."
  value       = aws_eks_cluster.eks.certificate_authority[0].data
}

output "oidc_provider_arn" {
  type        = string
  description = "OIDC Provider ARN for IRSA."
  value       = aws_iam_openid_connect_provider.oidc.arn
}
