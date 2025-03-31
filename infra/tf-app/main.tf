variable "resource_prefix" {
  description = "A prefix to add to all resources"
  type        = string
  default     = "wair0001"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_prefix}-a12-rg"
  location = "westus3"
}

output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
}