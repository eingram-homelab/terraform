provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "rg" {
  name = "HomeLabRG"
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "HomeLabRG-law-stg"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  daily_quota_gb      = 1
}
