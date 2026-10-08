module "rg" {
  source   = "../../../resource-group"
  name     = "rg-aks-example"
  location = "eastus"
}

module "aks" {
  source              = "../../"
  name                = "aks-example-cluster"
  resource_group_name = module.rg.name
  location            = module.rg.location
  dns_prefix          = "aks-example"
  default_node_pool = {
    name       = "system"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }
}
