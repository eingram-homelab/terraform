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

resource "azurerm_network_interface" "vm_nic" {
  depends_on          = [azurerm_virtual_network.target, azurerm_subnet.target]
  name                = local.nic_name
  location            = local.effective_location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = local.subnet_id
    private_ip_address_allocation = var.private_ip_address == null ? "Dynamic" : "Static"
    private_ip_address            = var.private_ip_address
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "vm_nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  depends_on          = [azurerm_network_interface.vm_nic]
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = local.effective_location
  size                = var.vm_size
  admin_username      = var.admin_username
  custom_data         = var.cloud_init == null ? null : base64encode(var.cloud_init)
  tags                = var.tags
  provision_vm_agent  = var.enable_waagent_extension

  boot_diagnostics {
    storage_account_uri = null
  }

  admin_ssh_key {
    public_key = var.public_key
    username   = var.admin_username
  }

  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.image.publisher
    offer     = var.image.offer
    sku       = var.image.sku
    version   = var.image.version
  }
}

resource "azurerm_virtual_machine_extension" "azure_monitor_agent" {
  count                      = var.enable_monitor_agent_extension ? 1 : 0
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  settings = jsonencode({})
}
