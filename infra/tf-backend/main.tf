terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Variables
variable "college_id" {
  description = "Your college ID used for naming resources"
  type        = string
  default     = "wair0001"
}

variable "location" {
  description = "Azure region to deploy resources in"
  type        = string
  default     = "westus3"
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.college_id}-githubactions-rg"
  location = var.location
}

# Storage Account
resource "azurerm_storage_account" "sa" {
  name                            = lower("${var.college_id}githubactions")
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
}

# Container for Terraform state
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

# Outputs
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "container_name" {
  value = azurerm_storage_container.tfstate.name
}

output "storage_account_primary_access_key" {
  value     = azurerm_storage_account.sa.primary_access_key
  sensitive = true
}