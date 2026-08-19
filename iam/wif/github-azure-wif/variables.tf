variable "azure_tenant_id" {
  description = "Azure AD Tenant ID"
  type        = string
}

variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "federated_identity_credentials" {
  description = "Federated identity credentials to create for the GitHub Terraform managed identity"
  type = map(object({
    display_name = string
    description  = string
    audiences    = list(string)
    issuer       = string
    subject      = string
  }))
  default = {}
}

variable "resource_group_name" {
  description = "Resource group in which to create the GitHub Terraform managed identity"
  type        = string
  default     = "rg-shared-resources"
}

variable "user_assigned_identity_name" {
  description = "Name of the user-assigned managed identity for GitHub Terraform"
  type        = string
  default     = "github-terraform-identity"
}

variable "azure_role_assignment" {
  description = "Azure role assignment configuration for the GitHub Terraform managed identity"
  type = object({
    scope = string
    role  = string
  })
  default = {
    scope = null
    role  = "Contributor"
  }
}
