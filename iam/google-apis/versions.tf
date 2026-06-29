terraform {
  required_version = ">= 1.0"

  required_providers {
    azuread = {
      source  = "hashicorp/google"
      version = ">= 7.38.0"
    }
  }
}
