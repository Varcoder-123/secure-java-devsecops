variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "app_subnet_name" {
  description = "Name of the application subnet"
  type        = string
}

variable "app_subnet_prefix" {
  description = "Address prefix for the application subnet"
  type        = list(string)
}

variable "db_subnet_name" {
  description = "Name of the database subnet"
  type        = string
}

variable "db_subnet_prefix" {
  description = "Address prefix for the database subnet"
  type        = list(string)
}

variable "app_nsg_name" {
  type = string
}

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "app_nic_name" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "vm_admin_username" {
  type = string
}

variable "mysql_dns_name" {
  type = string
}

variable "mysql_dns_link_name" {
  type = string
}

variable "mysql_server_name" {
  type = string
}

variable "mysql_admin_username" {
  type = string
}

variable "mysql_database_name" {
  type = string
}

variable "app_lb_name" {
  type = string
}

variable "public_ip_name" {
  type = string
}

variable "backend_pool" {
  type = string
}

variable "domain_name_label" {
  type = string
}

variable "nat_public_ip_name" {
  type = string
}

variable "nat_gateway_name" {
  type = string
}

variable "public_subnet_name" {
  description = "Name of the public subnet"
  type        = string
}

variable "public_subnet_prefix" {
  description = "Address prefix for the public subnet"
  type        = list(string)
}

variable "bastion_pip_name" {
  description = "Name of the public IP for Bastion"
  type        = string
}

variable "bastion_name" {
  description = "Name of the Bastion host"
  type        = string
}