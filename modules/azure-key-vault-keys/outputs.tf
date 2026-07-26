output "key_ids" {
  value = { for key_name, key_resource in azurerm_key_vault_key.key : key_name => key_resource.id }
}

output "key_versions" {
  value = { for key_name, key_resource in azurerm_key_vault_key.key : key_name => key_resource.version }
}
