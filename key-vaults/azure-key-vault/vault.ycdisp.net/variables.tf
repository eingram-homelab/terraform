variable "azuread_app" {
  type = object({
    app_name               = string
    app_description        = string
    app_password           = optional(bool, false)
    service_principal_name = optional(string, "")
  })
}

variable "key_vault" {
  type = object({
    name                            = string
    location                        = string
    resource_group_name             = string
    tenant_id                       = optional(string)
    sku_name                        = optional(string, "standard")
    enabled_for_deployment          = optional(bool, false)
    enabled_for_disk_encryption     = optional(bool, false)
    enabled_for_template_deployment = optional(bool, false)
    rbac_authorization_enabled      = optional(bool, false)
    purge_protection_enabled        = optional(bool, true)
    public_network_access_enabled   = optional(bool, true)
    soft_delete_retention_days      = optional(number, 90)
    access_policies = optional(list(object({
      object_id               = string
      key_permissions         = optional(list(string), [])
      secret_permissions      = optional(list(string), [])
      certificate_permissions = optional(list(string), [])
    })), [])
    network_acls = optional(object({
      bypass                     = string
      default_action             = string
      ip_rules                   = list(string)
      virtual_network_subnet_ids = list(string)
    }))
  })
}

variable "keys" {
  description = "Map of Key Vault keys to create."
  type = map(object({
    key_type        = string
    key_size        = optional(number)
    curve           = optional(string)
    key_opts        = list(string)
    not_before_date = optional(string)
    expiration_date = optional(string)
    tags            = optional(map(string), {})
    rotation_policy = optional(object({
      expire_after         = optional(string)
      notify_before_expiry = optional(string)
      time_after_creation  = optional(string)
      time_before_expiry   = optional(string)
    }))
  }))
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
