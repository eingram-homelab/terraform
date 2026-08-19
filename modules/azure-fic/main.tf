# Azure Configuration
resource "azuread_application_federated_identity_credential" "fic" {
  application_id = var.fic_application_id
  display_name   = var.fic_display_name
  description    = var.fic_description
  audiences      = var.fic_audiences
  issuer         = var.fic_issuer
  subject        = var.fic_subject
}
