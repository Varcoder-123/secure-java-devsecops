resource "azurerm_network_interface" "app_nic" {
  name                = var.app_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {

    name = "internal" #This is the label for the IP configuration

    subnet_id = var.app_subnet_id

    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {

  name                = "java-app-vm"
  resource_group_name = var.resource_group_name
  location            = var.location

  size = "Standard_B2ls_v2"

  admin_username = var.vm_admin_username
  
  admin_password = var.vm_admin_password

  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.app_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {

    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

