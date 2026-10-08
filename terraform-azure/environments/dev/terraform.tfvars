workload    = "core"
environment = "dev"
location    = "eastus"
owner       = "devops-team"
cost_center = "cc-88712"
project     = "azure-enterprise"

vnet_cidr = "10.10.0.0/16"

subnets = {
  "web" = {
    address_prefixes = ["10.10.1.0/24"]
  }
  "app" = {
    address_prefixes = ["10.10.2.0/24"]
  }
}

nsg_rules = [
  {
    name                   = "AllowHTTPSInbound"
    priority               = 100
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    destination_port_range = "443"
    source_address_prefix  = "*"
  }
]

custom_routes = [
  {
    name           = "DefaultRoute"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
]

public_ips = {
  "pip-app01" = {
    allocation_method = "Static"
    sku               = "Standard"
  }
}

vms = {
  "app01" = {
    size             = "Standard_B2s"
    subnet_key       = "web"
    enable_public_ip = true
  }
}

admin_username                = "azureadmin"
admin_ssh_public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3... example-key"
kv_public_network_access      = true
storage_replication_type      = "LRS"
storage_public_network_access = true

storage_containers = {
  "appdata" = {
    container_access_type = "private"
  }
}

managed_identities = {
  "id-app-runner" = {
    role_assignments = []
  }
}
