azuread_app = {
  app_name               = "hashicorp-vault"
  app_description        = "Home Lab HashiCorp Vault Azure AD App Registration"
  app_password           = true
  service_principal_name = "sp-hashicorp-vault"
  redirect_uris          = ["https://vault.ycdisp.net/ui/vault/auth/oidc/oidc/callback"]
  redirect_uri_type      = "Web"
}

tags = {
  environment = "prod"
}
