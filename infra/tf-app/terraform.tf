terraform {
  required_version = "~> 1.5"

  backend "azurerm" {
    resource_group_name  = "wair0001-githubactions-rg"
    storage_account_name = "wair0001githubactions"
    container_name       = "tfstate"
    key                  = "prod.app.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.96.0"
    }
  }
}
provider "azurerm" {
  features {}
}