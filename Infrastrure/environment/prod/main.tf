module "network" {
  source              = "../../modules/network"
  vnet_name           = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
  app_subnet_name     = var.app_subnet_name
  app_subnet_prefix   = var.app_subnet_prefix
  db_subnet_name      = var.db_subnet_name
  db_subnet_prefix    = var.db_subnet_prefix
}

module "security" {
  source              = "../../modules/security"
  app_nsg_name        = var.app_nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rules      = var.security_rules
  app_subnet_id       = module.network.app_subnet_id
}