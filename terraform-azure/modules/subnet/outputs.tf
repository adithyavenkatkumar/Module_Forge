output "subnets" {
  type = map(object({
    id               = string
    name             = string
    address_prefixes = list(string)
  }))
  description = "Map of created subnets."
  value = {
    for k, s in azurerm_subnet.subnets : k => {
      id               = s.id
      name             = s.name
      address_prefixes = s.address_prefixes
    }
  }
}
