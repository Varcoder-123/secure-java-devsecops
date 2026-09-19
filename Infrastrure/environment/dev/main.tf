data "azurerm_key_vault" "kv" {
  name                = "java3tier-keyvault"
  resource_group_name = "terraform-backend-rg"
}

data "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-admin-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "mysql_password" {
  name         = "mysql-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_virtual_network" "devops" {
  name                = "testing-vnet"
  resource_group_name = "Nexus"
}

module "network" {
  source              = "../../modules/network"
  vnet_name           = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
  public_subnet_name   = var.public_subnet_name
  public_subnet_prefix = var.public_subnet_prefix
  app_subnet_name     = var.app_subnet_name
  app_subnet_prefix   = var.app_subnet_prefix
  db_subnet_name      = var.db_subnet_name
  db_subnet_prefix    = var.db_subnet_prefix
  nat_public_ip_name  = var.nat_public_ip_name
  nat_gateway_name    = var.nat_gateway_name
  bastion_pip_name    = var.bastion_pip_name
  bastion_name        = var.bastion_name
  devops_vnet_id      = data.azurerm_virtual_network.devops.id
}

module "security" {
  source              = "../../modules/security"
  app_nsg_name        = var.app_nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rules      = var.security_rules
  app_subnet_id       = module.network.app_subnet_id
}

module "compute" {
  source              = "../../modules/compute"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_nic_name        = var.app_nic_name
  app_subnet_id       = module.network.app_subnet_id
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  vm_admin_username   = var.vm_admin_username
  vm_admin_password   = data.azurerm_key_vault_secret.vm_password.value
}

module "database" {
  source              = "../../modules/database"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  mysql_dns_name      = var.mysql_dns_name
  mysql_dns_link_name = var.mysql_dns_link_name
  mysql_server_name   = var.mysql_server_name
  mysql_admin_username = var.mysql_admin_username
  mysql_admin_password = data.azurerm_key_vault_secret.mysql_password.value
  mysql_database_name  = var.mysql_database_name
  vnet_id              = module.network.vnet_id
  db_subnet_id         = module.network.db_subnet_id 
}

module "loadbalancer" {
  source              = "../../modules/loadbalancer"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_lb_name         = var.app_lb_name
  public_ip_name      = var.public_ip_name
  backend_pool_name   = var.backend_pool
  domain_name_label   = var.domain_name_label
  app_nic_id          = module.compute.app_nic_id
}