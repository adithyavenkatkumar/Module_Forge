output "id" {
  type        = string
  description = "AKS Cluster ID."
  value       = azurerm_kubernetes_cluster.aks.id
}

output "name" {
  type        = string
  description = "AKS Cluster Name."
  value       = azurerm_kubernetes_cluster.aks.name
}

output "oidc_issuer_url" {
  type        = string
  description = "OIDC Issuer URL."
  value       = azurerm_kubernetes_cluster.aks.oidc_issuer_url
}

output "kube_config_raw" {
  type        = string
  description = "Raw Kubeconfig content."
  sensitive   = true
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
}
