# Azure App Registration
data "azuread_client_config" "current" {}

resource "azuread_application_registration" "app" {
  display_name     = var.app_name
  description      = var.app_description
  sign_in_audience = "AzureADMyOrg"

  #   homepage_url          = "https://app.example.com/"
  #   logout_url            = "https://app.example.com/logout"
  #   marketing_url         = "https://example.com/"
  #   privacy_statement_url = "https://example.com/privacy"
  #   support_url           = "https://support.example.com/"
  #   terms_of_service_url  = "https://example.com/terms"
}

output "application_id" {
  description = "The application/client ID of the Azure app registration"
  value       = azuread_application_registration.app.client_id
}

output "object_id" {
  description = "The object ID of the Azure app registration"
  value       = azuread_application_registration.app.object_id
}
