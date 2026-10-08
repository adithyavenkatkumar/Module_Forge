output "nics" {
  type = map(object({
    id                 = string
    private_ip_address = string
  }))
  description = "Map of created NICs."
  value = {
    for k, n in azurerm_network_interface.nic : k => {
      id                 = n.id
      private_ip_address = n.private_ip_address
    }
  }
}
