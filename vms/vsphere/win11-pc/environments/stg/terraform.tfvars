# terraform.tfvars is loaded automatically by Terraform.

vsphere_server       = "vcsa-1.local.lan"
allow_unverified_ssl = true

vsphere_datastore_list = ["vsanDatastore"]
vm_storage_policy      = "vSAN Default Storage Policy"
vsphere_network_list   = ["DPG-Lab-LAN1"]
vm_name_list           = ["win11-pc"]
vm_ram                 = 4096
vm_cpu                 = 2
vm_base_disk_size_gb   = [62]
vm_efi_secure          = false

ip_address_list = []
ip_gateway_list = []

dns_suffix_list = ["ycdisp.net"]
dns_server_list = []

# Set domain or workgroup
# domain = "homelab.local"
workgroup = "WORKGROUP"

# Uncomment domain_* for domain only
# domain_user = data.vault_generic_secret.hladmin_username.data["hladmin_username"]
# domain_password = data.vault_generic_secret.hladmin_password.data["hladmin_password"]

# Optional overrides (leave null to use Vault-backed defaults from main.tf)
admin_password = null
ssh_key        = null

vm_tag_categories = ["Environment"]
vm_tags           = ["dev"]

vsphere_template = "TMP-Win11_Packer"
is_windows_image = true
vm_folder_name   = "WindowsWG"

# Optional override. Leave empty to use default commands from main.tf
run_once_command_list = []

data_disk = {
  disk1 = {
    size_gb          = 60,
    thin_provisioned = true
  }
}

# Set these options to true for k8s nodes using vSphere CSI
enable_disk_uuid      = false
create_vm_permissions = false

# If enabling the above, must set these options to create a user and role for the VM to use for CSI
# vm_user_id = "vsphere.local\\csi"
# vm_role_name = "CNS-VM"
# vm_permissions_propagate = false
