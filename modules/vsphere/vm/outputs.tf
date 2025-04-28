output "name" {
  description = "VM Names"
  value       = vsphere_virtual_machine.vm.*.name
}

output "default_ip_address" {
  description = "default ip address of the deployed VM"
  value       = vsphere_virtual_machine.vm.*.default_ip_address
}

output "guest_ip_addresses" {
  description = "all the registered ip address of the VM"
  value       = vsphere_virtual_machine.vm.*.guest_ip_addresses
}

output "dns_suffix_list" {
  description = "DNS Suffix List of the VM"
  value       = vsphere_virtual_machine.vm.*.dns_suffix_list
}
output "uuid" {
  description = "UUID of the VM in vSphere"
  value       = vsphere_virtual_machine.vm.*.uuid
}

output "disk" {
  description = "Disks of the deployed VM"
  value       = vsphere_virtual_machine.vm.*.disk
}