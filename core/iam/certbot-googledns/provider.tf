provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

provider "azuread" {
  tenant_id = var.az_tenant_id
}