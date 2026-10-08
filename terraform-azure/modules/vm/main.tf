resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.size
  admin_username                  = var.admin_username
  admin_password                  = var.disable_password_authentication ? null : var.admin_password
  disable_password_authentication = var.disable_password_authentication
  network_interface_ids           = var.network_interface_ids
  tags                            = merge(var.tags, { ManagedBy = "terraform" })

  os_disk {
    caching              = lookup(var.os_disk, "caching", "ReadWrite")
    storage_account_type = lookup(var.os_disk, "storage_account_type", "Standard_LRS")
    disk_size_gb         = lookup(var.os_disk, "disk_size_gb", 30)
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  dynamic "admin_ssh_key" {
    for_each = var.admin_ssh_public_key != null ? [1] : []
    content {
      username   = var.admin_username
      public_key = var.admin_ssh_public_key
    }
  }

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids
    }
  }
}

resource "azurerm_managed_disk" "data_disk" {
  for_each             = var.data_disks
  name                 = "${var.name}-disk-${each.key}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = lookup(each.value, "storage_account_type", "Standard_LRS")
  create_option        = "Empty"
  disk_size_gb         = each.value.disk_size_gb
  tags                 = merge(var.tags, { ManagedBy = "terraform" })
}

resource "azurerm_virtual_machine_data_disk_attachment" "attachment" {
  for_each           = var.data_disks
  managed_disk_id    = azurerm_managed_disk.data_disk[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  lun                = each.value.lun
  caching            = lookup(each.value, "caching", "ReadWrite")
}
