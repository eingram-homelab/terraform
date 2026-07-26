azuread_app = {
  app_name               = "hl-vault1"
  app_description        = "Home Lab Key Vault 1"
  app_password           = true
  service_principal_name = "sp-hl-vault1"
}

key_vault = {
  name                = "kv-hl-vault1"
  location            = "westus"
  resource_group_name = "HomeLabRG"

  rbac_authorization_enabled    = false
  purge_protection_enabled      = true
  public_network_access_enabled = true
  soft_delete_retention_days    = 7

  # Automatically injected in code:
  # 1) Azure AD app policy (module.azuread_app.object_id)
  # 2) Current auth principal full policy (data.azurerm_client_config.current.object_id)
  # Keep this list only for any extra principals.
  access_policies = []

  network_acls = {
    bypass                     = "None"
    default_action             = "Allow"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
}

keys = {
  vault-unseal-key = {
    key_type = "RSA"
    key_size = 2048
    key_opts = ["unwrapKey", "wrapKey"]
    rotation_policy = {
      expire_after         = "P180D"
      notify_before_expiry = "P30D"
      time_before_expiry   = "P30D"
    }
  }
}

tags = {
  environment = "prod"
}
