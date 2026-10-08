resource "azurerm_user_assigned_identity" "identity" {
  for_each            = var.identities
  name                = each.key
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = merge(var.tags, { ManagedBy = "terraform" })
}

locals {
  role_assignments = flatten([
    for id_key, id_val in var.identities : [
      for role in lookup(id_val, "role_assignments", []) : {
        key                  = "${id_key}-${role.role_definition_name}-${role.scope}"
        principal_id         = azurerm_user_assigned_identity.identity[id_key].principal_id
        role_definition_name = role.role_definition_name
        scope                = role.scope
      }
    ]
  ])
}

resource "azurerm_role_assignment" "roles" {
  for_each             = { for r in local.role_assignments : r.key => r }
  scope                = each.value.scope
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id
}
