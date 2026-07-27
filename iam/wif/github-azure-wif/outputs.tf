# Azure AD Configuration
output "azure_application_id" {
  description = "Azure AD Application (Client) ID for GitHub Actions"
  value       = azuread_application.github_actions.client_id
}

output "azure_service_principal_id" {
  description = "Azure AD Service Principal Object ID"
  value       = azuread_service_principal.github_actions.object_id
}

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
    for cred in azuread_application_federated_identity_credential.github :
    cred.display_name => {
      issuer    = cred.issuer
      subject   = cred.subject
      audiences = cred.audiences
    }
  }
}

output "github_actions_environment_variables" {
  description = "Environment variables needed for GitHub Actions setup"
  value = {
    AZURE_CLIENT_ID       = azuread_application.github_actions.client_id
    AZURE_TENANT_ID       = var.azure_tenant_id
    AZURE_SUBSCRIPTION_ID = var.azure_subscription_id
  }
}
