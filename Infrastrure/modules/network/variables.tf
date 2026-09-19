variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "app_subnet_name" {
  type = string
}

variable "app_subnet_prefix" {
  type = list(string)
}

variable "db_subnet_name" {
  type = string
}

variable "db_subnet_prefix" {
  type = list(string)
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
  type = string
}

variable "bastion_name" {
  type = string
}

variable "devops_vnet_id" {
  description = "The ID of the DevOps virtual network to peer with"
  type        = string
}