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

resource "azuread_application_redirect_uris" "app" {
  count          = length(var.redirect_uris) > 0 ? 1 : 0
  application_id = azuread_application_registration.app.id
  type           = var.redirect_uri_type
  redirect_uris  = var.redirect_uris
}

resource "azuread_application_password" "app" {
  count          = var.app_password ? 1 : 0
  application_id = azuread_application_registration.app.id
  display_name   = "${var.app_name}-secret"
}

resource "azuread_service_principal" "app" {
  client_id                    = azuread_application_registration.app.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]

  feature_tags {
    enterprise = true
    gallery    = false
    hide       = false
  }
}
