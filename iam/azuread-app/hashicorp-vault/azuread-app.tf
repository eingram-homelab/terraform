module "azuread_app" {
  source = "../../../modules/azuread-app"

  app_name               = var.azuread_app.app_name
  app_description        = var.azuread_app.app_description
  app_password           = var.azuread_app.app_password
  service_principal_name = var.azuread_app.service_principal_name
  redirect_uris          = var.azuread_app.redirect_uris
  redirect_uri_type      = var.azuread_app.redirect_uri_type
}
