output "identities" {
  type = map(object({
    id           = string
    principal_id = string
    client_id    = string
  }))
  description = "Map of created user assigned identities."
  value = {
    for k, i in azurerm_user_assigned_identity.identity : k => {
      id           = i.id
      principal_id = i.principal_id
      client_id    = i.client_id
    }
  }
}
