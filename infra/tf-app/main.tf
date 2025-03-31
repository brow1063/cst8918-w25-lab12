variable "resource_prefix" {
  description = "A prefix to add to all resources"
  type        = string
  default     = "wair0001"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_prefix}-a12-rg"
  location = "westus3"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_prefix}-a12-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.resource_prefix}-a12-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}