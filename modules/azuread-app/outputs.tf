output "application_id" {
  description = "The application/client ID of the Azure app registration"
  value       = azuread_application_registration.app.client_id
}

output "object_id" {
  description = "The object ID of the Azure app registration"
  value       = azuread_application_registration.app.object_id
}

output "service_principal_object_id" {
  description = "The object ID of the Azure AD service principal"
  value       = azuread_service_principal.app.object_id
}
