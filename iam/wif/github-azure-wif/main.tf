# Azure Configuration
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_user_assigned_identity" "github_terraform" {
  name                = var.user_assigned_identity_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}

resource "azurerm_federated_identity_credential" "github_terraform" {
  for_each = var.federated_identity_credentials

  name                = each.value.display_name
  resource_group_name = data.azurerm_resource_group.rg.name
  parent_id           = azurerm_user_assigned_identity.github_terraform.id
  audience            = each.value.audiences
  issuer              = each.value.issuer
  subject             = each.value.subject
}

module "github-terraform-identity-role-assignment" {
  source               = "../../../modules/azure-role-assignment"
  scope                = var.azure_role_assignment.scope != null ? var.azure_role_assignment.scope : "/subscriptions/${var.azure_subscription_id}"
  role_definition_name = var.azure_role_assignment.role
  subscription_id      = var.azure_subscription_id
  resource_group_name  = data.azurerm_resource_group.rg.name
  principal_id         = azurerm_user_assigned_identity.github_terraform.principal_id
}
