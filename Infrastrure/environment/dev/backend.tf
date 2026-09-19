terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-backend-rg"
    storage_account_name = "vigneshterraformstate01"
    container_name       = "tfstate"
    key                  = "dev.tfstate"
  }
}