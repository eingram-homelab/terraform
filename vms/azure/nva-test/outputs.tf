output "vm_id" {
  description = "ID of the deployed virtual machine."
  value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_name" {
  description = "Name of the deployed virtual machine."
  value       = azurerm_linux_virtual_machine.vm.name
}

output "nic_id" {
  description = "ID of the VM network interface."
  value       = azurerm_network_interface.vm_nic.id
}

output "private_ip_address" {
  description = "Primary private IP address assigned to the VM."
  value       = azurerm_network_interface.vm_nic.private_ip_address
}

output "public_ip_address" {
  description = "Public IP address assigned to the VM (if any)."
  value       = azurerm_public_ip.vm_public_ip.ip_address
}

output "vnet_id" {
  description = "ID of the VNet used by the VM (existing or created)."
  value       = local.vnet_id
}

output "subnet_id" {
  description = "ID of the subnet used by the VM (existing or created)."
  value       = local.subnet_id
}

output "create_vnet" {
  description = "Whether this deployment created the VNet and subnet."
  value       = var.create_vnet
}

output "waagent_extension_enabled" {
  description = "Whether waagent bootstrap extension is enabled."
  value       = var.enable_waagent_extension
}

output "monitor_agent_extension_enabled" {
  description = "Whether Azure Monitor Agent extension is enabled."
  value       = var.enable_monitor_agent_extension
}
