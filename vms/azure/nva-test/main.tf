terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 5.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "vault" {
}

locals {
  effective_location = coalesce(var.location, data.azurerm_resource_group.target.location)
  vnet_id            = var.create_vnet ? azurerm_virtual_network.target[0].id : data.azurerm_virtual_network.target[0].id
  subnet_id          = var.create_vnet ? azurerm_subnet.target[0].id : data.azurerm_subnet.target[0].id
  nic_name           = coalesce(var.network_interface_name, "${var.vm_name}-nic")
}

data "azurerm_resource_group" "target" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "target" {
  count               = var.create_vnet ? 0 : 1
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "target" {
  count                = var.create_vnet ? 0 : 1
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_virtual_network" "target" {
  count               = var.create_vnet ? 1 : 0
  name                = var.vnet_name
  location            = local.effective_location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "target" {
  depends_on           = [azurerm_virtual_network.target]
  count                = var.create_vnet ? 1 : 0
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_public_ip" "vm_public_ip" {
  name                = "${var.vm_name}-public-ip"
  location            = local.effective_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_security_group" "vm_nsg" {
  name                = "${var.vm_name}-nsg"
  location            = local.effective_location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

