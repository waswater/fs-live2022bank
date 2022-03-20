terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.46.0"
    }
  }
    backend "azurerm" {
        resource_group_name  = ""
        storage_account_name = ""
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}