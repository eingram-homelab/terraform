provider "vault" {
}

data "vault_generic_secret" "vsphere_username" {
  path = var.vault_vsphere_secret_path
}

data "vault_generic_secret" "vsphere_password" {
  path = var.vault_vsphere_secret_path
}

data "vault_generic_secret" "ssh_password" {
  path = var.vault_ssh_secret_path
}

data "vault_generic_secret" "win_password" {
  path = var.vault_win_secret_path
}

data "vault_generic_secret" "ssh_pub_key" {
  path = var.vault_ssh_secret_path
}

data "vault_generic_secret" "hladmin_username" {
  path = var.vault_hladmin_secret_path
}

data "vault_generic_secret" "hladmin_password" {
  path = var.vault_hladmin_secret_path
}

provider "vsphere" {
  user                 = data.vault_generic_secret.vsphere_username.data["vsphere_username"]
  password             = data.vault_generic_secret.vsphere_password.data["vsphere_password"]
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = var.allow_unverified_ssl
}

module "vm" {
  source = "../../../modules/vsphere/vm"
  vsphere_datastore_list = var.vsphere_datastore_list
  vsphere_network_list   = var.vsphere_network_list
  vm_name_list           = var.vm_name_list
  ip_address_list        = var.ip_address_list
  ip_gateway_list        = var.ip_gateway_list
  dns_suffix_list = var.dns_suffix_list
  vm_tag_categories = var.vm_tag_categories
  vm_tags = var.vm_tags
  vsphere_template = var.vsphere_template
  is_windows_image = var.is_windows_image
  vm_folder_name = var.vm_folder_name
  domain = var.domain
  admin_password = var.admin_password != null ? var.admin_password : data.vault_generic_secret.win_password.data["win_password"]
  ssh_key        = var.ssh_key != null ? var.ssh_key : data.vault_generic_secret.ssh_pub_key.data["ssh_pub_key"]
  run_once_command_list = var.run_once_command_list
  vm_ram               = var.vm_ram
  vm_cpu               = var.vm_cpu
  vm_base_disk_size_gb = var.vm_base_disk_size_gb # Comment to use template size | minumum 62
  vm_efi_secure        = var.vm_efi_secure
  enable_disk_uuid         = var.enable_disk_uuid
  create_vm_permissions    = var.create_vm_permissions
  vm_user_id               = var.vm_user_id
  vm_role_name             = var.vm_role_name
  vm_permissions_propagate = var.vm_permissions_propagate
  vm_storage_policy = var.vm_storage_policy
  dns_server_list = var.dns_server_list
  data_disk = var.data_disk
}