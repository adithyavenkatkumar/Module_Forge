workload    = "enterprise"
environment = "prod"
location    = "eastus"
owner       = "platform-team"
cost_center = "cc-90001"
project     = "azure-enterprise-landing-zone"

vnet_cidr = "10.200.0.0/16"

subnets = {
  "web" = {
    address_prefixes = ["10.200.1.0/24"]
  }
  "app" = {
    address_prefixes = ["10.200.2.0/24"]
  }
  "data" = {
    address_prefixes = ["10.200.3.0/24"]
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
    name           = "InternetDefault"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
]

public_ips = {
  "pip-web-01" = {
    allocation_method = "Static"
    sku               = "Standard"
  }
}

vms = {
  "web-01" = {
    size             = "Standard_D2s_v5"
    subnet_key       = "web"
    enable_public_ip = true
  }
}

admin_username                = "azureadmin"
admin_ssh_public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3... enterprise-key"
kv_public_network_access      = false
storage_replication_type      = "GRS"
storage_public_network_access = false

storage_containers = {
  "enterprise-blobs" = {
    container_access_type = "private"
  }
}

managed_identities = {
  "id-enterprise-app" = {
    role_assignments = []
  }
}
