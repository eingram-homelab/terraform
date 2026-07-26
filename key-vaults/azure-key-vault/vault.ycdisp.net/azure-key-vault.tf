data "azurerm_client_config" "current" {}

module "azure_key_vault" {
  source = "../../../modules/azure-key-vault"

  access_policies = concat(
    [
      {
        tenant_id       = data.azurerm_client_config.current.tenant_id
        object_id       = module.azuread_app.service_principal_object_id
        key_permissions = ["Get", "WrapKey", "UnwrapKey", ]
      },
      {
        tenant_id               = data.azurerm_client_config.current.tenant_id
        object_id               = data.azurerm_client_config.current.object_id
        key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "GetRotationPolicy", "SetRotationPolicy", "Rotate"]
        certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers"]
        secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"]
      }
    ],
    var.key_vault.access_policies
  )

  name                            = var.key_vault.name
  location                        = var.key_vault.location
  resource_group_name             = var.key_vault.resource_group_name
  tenant_id                       = coalesce(var.key_vault.tenant_id, data.azurerm_client_config.current.tenant_id)
  sku_name                        = var.key_vault.sku_name
  enabled_for_deployment          = var.key_vault.enabled_for_deployment
  enabled_for_disk_encryption     = var.key_vault.enabled_for_disk_encryption
  enabled_for_template_deployment = var.key_vault.enabled_for_template_deployment
  rbac_authorization_enabled      = var.key_vault.rbac_authorization_enabled
  purge_protection_enabled        = var.key_vault.purge_protection_enabled
  public_network_access_enabled   = var.key_vault.public_network_access_enabled
  soft_delete_retention_days      = var.key_vault.soft_delete_retention_days
  network_acls                    = var.key_vault.network_acls
  tags                            = var.tags

  depends_on = [module.azuread_app]
}
