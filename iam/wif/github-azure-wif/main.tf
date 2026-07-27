# Azure Configuration
resource "azuread_application" "github_actions" {
  display_name = "GitHub Actions - Terraform"
  description  = "Application for GitHub Actions OIDC authentication"
}

resource "azuread_service_principal" "github_actions" {
  client_id = azuread_application.github_actions.client_id
}

resource "azuread_application_federated_identity_credential" "github" {
  for_each = toset(var.allowed_repositories)

  application_id = azuread_application.github_actions.id
  display_name   = "GitHub ${each.value}"
  description    = "Federated identity for ${each.value}"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:${each.value}:ref:refs/heads/main"
}

resource "azurerm_role_assignment" "github_actions" {
  scope                = var.azure_role_assignment.scope != null ? var.azure_role_assignment.scope : "/subscriptions/${var.azure_subscription_id}/resourceGroups/${var.azure_resource_group_name}"
  role_definition_name = var.azure_role_assignment.role
  principal_id         = azuread_service_principal.github_actions.object_id
}

resource "azurerm_role_assignment" "key_vault_admin" {
  count                = var.azure_ad_directory_roles.azure_key_vault_administrator ? 1 : 0
  scope                = "/subscriptions/${var.azure_subscription_id}/resourceGroups/${var.azure_resource_group_name}"
  role_definition_name = "Key Vault Administrator"
  principal_id         = azuread_service_principal.github_actions.object_id
}

# Azure AD Directory Roles for IAM object creation
data "azuread_directory_role" "application_developer" {
  count        = var.azure_ad_directory_roles.application_developer ? 1 : 0
  display_name = "Application Developer"
}

resource "azuread_directory_role_member" "application_developer" {
  count            = var.azure_ad_directory_roles.application_developer ? 1 : 0
  role_object_id   = data.azuread_directory_role.application_developer[0].object_id
  member_object_id = azuread_service_principal.github_actions.object_id
}

data "azuread_directory_role" "cloud_application_admin" {
  count        = var.azure_ad_directory_roles.cloud_application_admin ? 1 : 0
  display_name = "Cloud Application Administrator"
}

resource "azuread_directory_role_member" "cloud_application_admin" {
  count            = var.azure_ad_directory_roles.cloud_application_admin ? 1 : 0
  role_object_id   = data.azuread_directory_role.cloud_application_admin[0].object_id
  member_object_id = azuread_service_principal.github_actions.object_id
}

data "azuread_directory_role" "directory_writers" {
  count        = var.azure_ad_directory_roles.directory_writers ? 1 : 0
  display_name = "Directory Writers"
}

resource "azuread_directory_role_member" "directory_writers" {
  count            = var.azure_ad_directory_roles.directory_writers ? 1 : 0
  role_object_id   = data.azuread_directory_role.directory_writers[0].object_id
  member_object_id = azuread_service_principal.github_actions.object_id
}

