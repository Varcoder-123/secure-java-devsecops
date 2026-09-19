resource "azurerm_private_dns_zone" "mysql_dns" { //This resource creates a private DNS zone for the MySQL server.
  name                = var.mysql_dns_name
  resource_group_name = var.resource_group_name
}


resource "azurerm_private_dns_zone_virtual_network_link" "mysql_dns_link" { //This resource links the private DNS zone to the virtual network.
  name                  = var.mysql_dns_link_name
  private_dns_zone_name = azurerm_private_dns_zone.mysql_dns.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_mysql_flexible_server" "mysql" { //This resource creates a MySQL flexible server in Azure.
  name                = var.mysql_server_name
  resource_group_name = var.resource_group_name
  location            = var.location

  administrator_login    = var.mysql_admin_username
  administrator_password = var.mysql_admin_password

  sku_name = "B_Standard_B1ms"

  version = "8.0.21"

  delegated_subnet_id = var.db_subnet_id

  private_dns_zone_id = azurerm_private_dns_zone.mysql_dns.id

  backup_retention_days       = 7
  geo_redundant_backup_enabled = false

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.mysql_dns_link
  ]
}

resource "azurerm_mysql_flexible_database" "appdb" { //This resource creates a MySQL database within the flexible server.
  name                = var.mysql_database_name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  resource_group_name = var.resource_group_name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}