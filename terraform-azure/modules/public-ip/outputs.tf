output "public_ips" {
  type = map(object({
    id         = string
    ip_address = string
    fqdn       = string
  }))
  description = "Map of created public IPs."
  value = {
    for k, p in azurerm_public_ip.pip : k => {
      id         = p.id
      ip_address = p.ip_address
      fqdn       = p.fqdn
    }
  }
}
