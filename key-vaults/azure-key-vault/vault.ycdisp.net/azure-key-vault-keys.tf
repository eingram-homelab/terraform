module "azure_key_vault_keys" {
  source = "../../../modules/azure-key-vault-keys"

  key_vault_id = module.azure_key_vault.id
  keys         = var.keys
}
