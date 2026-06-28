module "azuread_app" {
  source = "../../../modules/azuread-app"

  app_name        = var.app_name
  app_description = var.app_description
}
