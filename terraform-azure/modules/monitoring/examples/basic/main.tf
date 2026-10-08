module "rg" {
  source   = "../../../resource-group"
  name     = "rg-mon-example"
  location = "eastus"
}

module "monitoring" {
  source              = "../../"
  workspace_name      = "law-example-basic"
  resource_group_name = module.rg.name
  location            = module.rg.location
  app_insights_name   = "appi-example-basic"
}
