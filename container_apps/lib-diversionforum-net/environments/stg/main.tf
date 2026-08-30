provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "hl-rg" {
  name = "HomeLabRG"
}

data "azurerm_log_analytics_workspace" "law" {
  name                = "HomeLabRG-law-stg"
  resource_group_name = data.azurerm_resource_group.hl-rg.name
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "azure_vnet" {
  source              = "../../../../modules/azure-vnet"
  vnet_name            = "${var.app_name}-vnet"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  vnet_address_space   = var.vnet_address_space
  dns_servers          = var.dns_servers
  subnets              = var.subnets
  security_rules       = var.security_rules
  tags                 = var.tags
}

# resource "azurerm_storage_account" "app" {
#   count                    = length(var.file_shares) > 0 ? 1 : 0
#   name                     = var.storage_account_name
#   resource_group_name      = azurerm_resource_group.rg.name
#   location                = azurerm_resource_group.rg.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   tags                     = var.tags
# }

# resource "azurerm_storage_share" "app" {
#   for_each             = var.file_shares
#   name                 = each.key
#   storage_account_name = azurerm_storage_account.app[0].name
#   quota                = each.value.quota_gb
# }

module "azure_container_app" {
  depends_on          = [module.azure_vnet]
  source              = "../../../../modules/azure-container-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  app_name                      = var.app_name
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
  container_app = var.container_app
  container_app_environment = var.container_app_environment
  # volume_mounts = {
  #   for name, share in var.file_shares :
  #   name => {
  #     storage_account_name = azurerm_storage_account.app[0].name
  #     storage_account_key  = azurerm_storage_account.app[0].primary_access_key
  #     share_name           = azurerm_storage_share.app[name].name
  #     mount_path           = share.mount_path
  #   }
  # }
  tags                 = var.tags
}
