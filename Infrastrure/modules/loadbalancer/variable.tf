variable "public_ip_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "app_lb_name" {
  type = string
}

variable "backend_pool_name" {
  type = string
}

variable "domain_name_label" {
  type = string
}

variable "app_nic_id" {
  description = "The ID of the application network interface to associate with the load balancer backend pool"
  type        = string
}