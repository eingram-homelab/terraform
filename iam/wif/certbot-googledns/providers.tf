terraform {
  required_version = ">= 1.0"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 3.9.0"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 7.41.0"
    }
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

provider "azuread" {
  tenant_id = var.az_tenant_id
}
