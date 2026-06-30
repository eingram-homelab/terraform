resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = var.vnet_address_space
  dns_servers         = var.dns_servers

  subnet {
    name             = var.subnet_name
    address_prefixes = var.subnet_address_prefixes
  }

  tags = {
    environment = var.environment
  }
}