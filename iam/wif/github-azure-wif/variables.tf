variable "azure_tenant_id" {
  description = "Azure AD Tenant ID"
  type        = string
}

variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "azure_resource_group_name" {
  description = "Azure Resource Group for role assignments"
  type        = string
}

variable "azure_role_assignment" {
  description = "Azure role assignment configuration"
  type = object({
    scope = string
    role  = string
  })
  default = {
    scope = null
    role  = "Contributor"
  }
}

variable "azure_ad_directory_roles" {
  description = "Azure AD directory roles to assign to GitHub Actions service principal"
  type = object({
    application_developer         = bool
    azure_key_vault_administrator = bool
    cloud_application_admin       = bool
    directory_writers             = bool
  })
  default = {
    application_developer         = true
    azure_key_vault_administrator = false
    cloud_application_admin       = false
    directory_writers             = false
  }
}
