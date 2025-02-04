output "VM" {
  description = "VM Names"
  value       = module.vm.*.name
}

output "ip" {
  description = "default ip address of the deployed VM"
  value       = module.vm.*.default_ip_address
}

output "guest-ip" {
  description = "all the registered ip address of the VM"
  value       = module.vm.*.guest_ip_addresses
}

output "uuid" {
  description = "UUID of the VM in vSphere"
  value       = module.vm.*.uuid
}

output "disk" {
  description = "Disks of the deployed VM"
  value       = module.vm.*.disk
}