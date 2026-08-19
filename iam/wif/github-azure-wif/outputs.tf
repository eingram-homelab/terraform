output "azure_tenant_id" {
  description = "Azure AD Tenant ID"
  value       = var.azure_tenant_id
}

output "azure_subscription_id" {
  description = "Azure Subscription ID"
  value       = var.azure_subscription_id
}

output "azure_federated_credentials" {
  description = "Azure federated identity credentials created for repositories"
  value = {
    for name, credential in var.federated_identity_credentials :
    name => {
      issuer    = credential.issuer
      subject   = credential.subject
      audiences = credential.audiences
    }
  }
}

output "github_actions_environment_variables" {
  description = "Environment variables needed for GitHub Actions setup"
  value = {
    AZURE_CLIENT_ID       = azurerm_user_assigned_identity.github_terraform.client_id
    AZURE_TENANT_ID       = var.azure_tenant_id
    AZURE_SUBSCRIPTION_ID = var.azure_subscription_id
  }
}

output "github_terraform_managed_identity" {
  description = "GitHub Terraform user-assigned managed identity details"
  value = {
    id           = azurerm_user_assigned_identity.github_terraform.id
    client_id    = azurerm_user_assigned_identity.github_terraform.client_id
    principal_id = azurerm_user_assigned_identity.github_terraform.principal_id
  }
}
