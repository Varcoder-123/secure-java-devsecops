output "domain_name_label" {
    value = azurerm_public_ip.vm_pip.fqdn
}