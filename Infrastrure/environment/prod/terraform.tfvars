vm_password = "Vicky1867@123"
mysql_password = "Mysql@123456"

#network configuration
vnet_name = "devops-vnet"
address_space = ["10.0.0.0/16"]
public_subnet_name = "public-subnet"
public_subnet_prefix = ["10.0.1.0/24"]
app_subnet_name = "app-subnet"
app_subnet_prefix = ["10.0.2.0/24"]
db_subnet_name = "db-subnet"
db_subnet_prefix = ["10.0.3.0/24"]

#NSG configuration
app_nsg_name = "app-prod-nsg"
security_rules = [
  {
    name                       = "SSH"
    priority                   = 200
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
    priority                   = 300
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
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]
