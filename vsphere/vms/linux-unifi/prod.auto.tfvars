# terraform.tfvars is loaded automatically by Terraform.

vsphere_server       = "vcsa-1.local.lan"
allow_unverified_ssl = true

vsphere_datastore_list = ["vsanDatastore"]
vm_storage_policy      = "vSAN Default Storage Policy"
vsphere_network_list   = ["DPG-Services"]
vm_name_list           = ["unifi"]
vm_ram                 = 4196
vm_cpu                 = 1
vm_base_disk_size_gb   = [62]
vm_efi_secure          = false

ip_address_list = ["192.168.1.221"]
ip_gateway_list = ["192.168.1.1"]

dns_suffix_list = ["ycdisp.net"]
dns_server_list = ["192.168.1.251", "192.168.1.250"]

vm_tag_categories = ["Environment"]
vm_tags           = ["prod"]

vsphere_template = "TMP-Rocky10_Packer"
is_windows_image = false
vm_folder_name   = "Linux"
domain           = "ycdisp.net"

run_once_command_list = []
data_disk             = {}

# Needed for Kubernetes CSI, but can be set to false for other use cases
enable_disk_uuid      = false
create_vm_permissions = false