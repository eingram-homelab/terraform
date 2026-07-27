terraform {
  required_version = ">= 1.0"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}
provider "azuread" {
  tenant_id = var.azure_tenant_id
}

provider "azurerm" {
  subscription_id = var.azure_subscription_id
  features {}
}

data "azurerm_client_config" "current" {}
