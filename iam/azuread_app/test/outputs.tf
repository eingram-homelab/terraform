output "application_id" {
  description = "The application/client ID of the Azure app registration"
  value       = module.azuread_app.application_id
}

output "object_id" {
  description = "The object ID of the Azure app registration"
  value       = module.azuread_app.object_id
}
