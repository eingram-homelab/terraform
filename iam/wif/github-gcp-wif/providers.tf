terraform {
  required_version = ">= 1.0"

  required_providers {
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
