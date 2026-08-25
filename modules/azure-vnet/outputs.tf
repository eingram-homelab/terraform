output "subnet_id" {
   value = { for s in azurerm_virtual_network.vnet.subnet : s.name => s.id }
}