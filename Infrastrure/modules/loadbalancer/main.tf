resource "azurerm_public_ip" "vm_pip" {

  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"

  sku = "Standard"

  domain_name_label = var.domain_name_label
}

resource "azurerm_lb" "app_lb" {

  name                = var.app_lb_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku = "Standard"

  frontend_ip_configuration {

    name                 = "public-frontend"
    public_ip_address_id = azurerm_public_ip.vm_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {

  loadbalancer_id = azurerm_lb.app_lb.id

  name = var.backend_pool_name
}

resource "azurerm_lb_probe" "http_probe" {

  loadbalancer_id = azurerm_lb.app_lb.id

  name = "http-probe"

  protocol = "Http"

  port = 8080

  request_path = "/"

  interval_in_seconds = 5

  number_of_probes = 2

}

resource "azurerm_lb_rule" "http_rule" {

  loadbalancer_id = azurerm_lb.app_lb.id

  name = "http-rule"

  protocol = "Tcp"

  frontend_port = 80

  backend_port = 8080

  frontend_ip_configuration_name = "public-frontend"

  backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.backend_pool.id
  ]

  probe_id = azurerm_lb_probe.http_probe.id

}

resource "azurerm_network_interface_backend_address_pool_association" "app_lb_assoc" {

  network_interface_id    = var.app_nic_id

  ip_configuration_name   = "internal"

  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}