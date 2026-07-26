output "azureapp_application_id" {
  description = "The application/client ID of the Azure app registration"
  value       = azuread_application_registration.az_app.client_id
}

output "azureapp_object_id" {
  description = "The object ID of the Azure app registration"
  value       = azuread_application_registration.az_app.object_id
}

output "azureapp_service_principal_id" {
  description = "The object ID of the service principal"
  value       = azuread_service_principal.az_app.object_id
}

output "azureapp_application_uri" {
  description = "Application URI"
  value       = "api://${azuread_application_registration.az_app.client_id}"
}

output "gcp_project" {
  description = "GCP Project"
  value       = var.gcp_project
}

output "gcp_sa_account_id" {
  description = "GCP Service Account"
  value       = var.gcp_sa_account_id
}