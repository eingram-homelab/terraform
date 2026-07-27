azure_tenant_id           = "your-tenant-id"
azure_subscription_id     = "your-subscription-id"
azure_resource_group_name = "your-resource-group"

# Optional: Custom role assignment scope (defaults to resource group)
# azure_role_assignment = {
#   scope = "/subscriptions/your-sub-id"
#   role  = "Owner"
# }

# Enable/disable specific Azure AD directory roles for GitHub Actions
azure_ad_directory_roles = {
  application_developer         = true  # Can create applications and service principals
  azure_key_vault_administrator = false # Can manage Azure Key Vaults and their access policies
  cloud_application_admin       = false # Can manage all aspects of app registrations
  directory_writers             = false # Full CRUD on all directory objects (most permissive)
}
