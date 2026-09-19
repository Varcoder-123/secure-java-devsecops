#network configuration
vnet_name = "dev-vnet"
address_space = ["10.1.0.0/16"]
public_subnet_name = "AzureBastionSubnet"
public_subnet_prefix = ["10.1.0.0/24"]
app_subnet_name = "app-subnet"
app_subnet_prefix = ["10.1.1.0/24"]
db_subnet_name = "db-subnet"
db_subnet_prefix = ["10.1.5.0/24"]
nat_public_ip_name = "nat-public-ip"
nat_gateway_name = "nat-gateway"
bastion_pip_name = "bastion-public-ip"
bastion_name = "bastion-host"

#NSG configuration
app_nsg_name = "app-nsg"
security_rules = [
  {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "HTTPS"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "JavaApp"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

#Compute configuration
app_nic_name = "app-nic"
vm_name = "java-app-vm"
vm_size = "Standard_B2ls_v2"
vm_admin_username = "azureuser"

#Database configuration
mysql_dns_name = "mysql.private.mysql.database.azure.com"
mysql_dns_link_name = "mysql-dns-link"
mysql_server_name = "vigneshmysqlserver123"
mysql_admin_username = "mysqladmin"
mysql_database_name = "javaapp"

#Load Balancer configuration
app_lb_name = "app-load-balancer"
public_ip_name = "app-public-ip"
backend_pool = "backend-pool-dev"
domain_name_label = "java3tier-demo"


