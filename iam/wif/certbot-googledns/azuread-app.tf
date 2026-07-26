# Azure App Registration
data "azuread_client_config" "current" {}

resource "azuread_application_registration" "az_app" {
  display_name     = var.az_app_name
  description      = var.az_app_description
  sign_in_audience = "AzureADMyOrg"

  #   homepage_url          = "https://app.example.com/"
  #   logout_url            = "https://app.example.com/logout"
  #   marketing_url         = "https://example.com/"
  #   privacy_statement_url = "https://example.com/privacy"
  #   support_url           = "https://support.example.com/"
  #   terms_of_service_url  = "https://example.com/terms"
}

resource "azuread_application_identifier_uri" "az_app" {
  application_id = azuread_application_registration.az_app.id
  identifier_uri = "api://${azuread_application_registration.az_app.client_id}"
}

# Create service principal for the app registration
resource "azuread_service_principal" "az_app" {
  client_id                    = azuread_application_registration.az_app.client_id
  app_role_assignment_required = false
}
