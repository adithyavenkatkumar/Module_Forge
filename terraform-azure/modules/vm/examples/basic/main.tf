module "rg" {
  source   = "../../../resource-group"
  name     = "rg-vm-example"
  location = "eastus"
}

module "vnet" {
  source              = "../../../vnet"
  name                = "vnet-vm-example"
  resource_group_name = module.rg.name
  location            = module.rg.location
  address_space       = ["10.0.0.0/16"]
}

module "subnets" {
  source               = "../../../subnet"
  resource_group_name  = module.rg.name
  virtual_network_name = module.vnet.name
  subnets = {
    "vm-subnet" = { address_prefixes = ["10.0.1.0/24"] }
  }
}

module "nic" {
  source              = "../../../nic"
  resource_group_name = module.rg.name
  location            = module.rg.location
  nics = {
    "nic-vm-01" = { subnet_id = module.subnets.subnets["vm-subnet"].id }
  }
}

module "vm" {
  source                          = "../../"
  name                            = "vm-example-01"
  resource_group_name             = module.rg.name
  location                        = module.rg.location
  size                            = "Standard_B2s"
  admin_username                  = "azureuser"
  admin_ssh_public_key            = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3... test@example.com"
  disable_password_authentication = true
  network_interface_ids           = [module.nic.nics["nic-vm-01"].id]
}
