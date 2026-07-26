variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "standard"
}

variable "enabled_for_deployment" {
  type    = bool
  default = false
}

variable "enabled_for_disk_encryption" {
  type    = bool
  default = false
}

variable "enabled_for_template_deployment" {
  type    = bool
  default = false
}

variable "rbac_authorization_enabled" {
  type    = bool
  default = true
}

variable "purge_protection_enabled" {
  type    = bool
  default = true
}

variable "public_network_access_enabled" {
  type    = bool
  default = true
}

variable "soft_delete_retention_days" {
  type    = number
  default = 90
}

variable "access_policies" {
  type = list(object({
    tenant_id               = string
    object_id               = string
    key_permissions         = optional(list(string), [])
    secret_permissions      = optional(list(string), [])
    certificate_permissions = optional(list(string), [])
  }))
  default = []
}

variable "network_acls" {
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
