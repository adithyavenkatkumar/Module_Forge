variable "name" {
  type        = string
  description = "The name of the Virtual Machine."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure Region."
}

variable "size" {
  type        = string
  description = "SKU Size of the VM."
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "Admin username."
  default     = "azureuser"
}

variable "admin_password" {
  type        = string
  description = "Admin password (if password auth enabled)."
  sensitive   = true
  default     = null
}

variable "disable_password_authentication" {
  type        = bool
  description = "Boolean to disable password authentication."
  default     = true
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH Public Key content."
  default     = null
}

variable "network_interface_ids" {
  type        = list(string)
  description = "List of Network Interface IDs."
}

variable "os_disk" {
  type = object({
    caching              = optional(string, "ReadWrite")
    storage_account_type = optional(string, "Standard_LRS")
    disk_size_gb         = optional(number, 30)
  })
  description = "OS Disk configuration."
  default     = {}
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "OS Image reference."
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

variable "data_disks" {
  type = map(object({
    disk_size_gb         = number
    lun                  = number
    storage_account_type = optional(string, "Standard_LRS")
    caching              = optional(string, "ReadWrite")
  }))
  description = "Map of managed data disks."
  default     = {}
}

variable "identity_type" {
  type        = string
  description = "Type of Managed Identity (SystemAssigned, UserAssigned)."
  default     = "SystemAssigned"
}

variable "identity_ids" {
  type        = list(string)
  description = "List of User Assigned Identity IDs."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags map."
  default     = {}
}
