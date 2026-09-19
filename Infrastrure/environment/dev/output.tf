output "domain_name" {
  value = module.loadbalancer.domain_name_label
}

output "mysql_server" {
  value = module.database.mysql_server_url
}