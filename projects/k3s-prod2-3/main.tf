provider "google" {
  credentials = "/terraform/creds.json"
  gcp_project = "proj-yc-srv1"
  gcp_region  = "us-west1"
  gcp_zone    = "us-west1-a"
}

provider "vault" {
}

data "vault_generic_secret" "vsphere_username" {
  path = "secret/vsphere/vcsa"
}

data "vault_generic_secret" "vsphere_password" {
  path = "secret/vsphere/vcsa"
}

data "vault_generic_secret" "ssh_password" {
  path = "secret/ssh/ansible"
}

data "vault_generic_secret" "win_password" {
  path = "secret/win/administrator"
}

data "vault_generic_secret" "hladmin_username" {
  path = "secret/win/homelab"
}

data "vault_generic_secret" "hladmin_password" {
  path = "secret/win/homelab"
}

provider "vsphere" {
  user                 = data.vault_generic_secret.vsphere_username.data["vsphere_username"]
  password             = data.vault_generic_secret.vsphere_password.data["vsphere_password"]
  vsphere_server       = "vcsa-1.local.lan"
  allow_unverified_ssl = true
}

module "vm" {
  source = "../../modules/vsphere"

  # Set one per VM
  # All lists must have same # of elements

  vsphere_datastore_list = [
    "vsanDatastore",
    "vsanDatastore"
    # XN_iSCSI_SSD2,
    # XN_iSCSI_SSD2,
  ]
  vsphere_network_list = [
    # "DPG-Lab-LAN1"
    "DPG-Services",
    "DPG-Services"
  ]
  vm_name_list = [
    "k3s-prod2",
    "k3s-prod3"
    # k3s2,
    # k3s3
  ]
  ip_address_list = [
    "192.168.1.222",
    "192.168.1.232"
    # 10.10.0.52,
    # 10.10.0.53
  ]
  ip_gateway_list = [
    "192.168.1.1",
    "192.168.1.1"
    # 10.10.0.1,
    # 10.10.0.1
  ]
  dns_suffix_list = [
    # "homelab.local"
    "local.lan",
    "local.lan"
  ]

  # Global options apply to all VMs

  # Linux images
  # vsphere_template = TMP-RHEL85_Packer
  vsphere_template = "TMP-Rocky9_Packer"

  # Windows images
  # vsphere_template = "TMP-Win2022Core_Packer"
  # vsphere_template = "TMP-Win2016_Packer"
  # vsphere_template = TMP-Win2019_Packer

  # true for Windows, false for Linux
  is_windows_image = false

  # Set vm folder location
  vm_folder_name = "Linux"
  # vm_folder_name = "WindowsWG"
  # vm_folder_name = "WindowsHL"

  # Set domain or workgroup
  # domain = "homelab.local"
  # workgroup = "WORKGROUP"

  # Uncomment domain_* for domain only
  # domain_user = data.vault_generic_secret.hladmin_username.data["hladmin_username"]
  # domain_password = data.vault_generic_secret.hladmin_password.data["hladmin_password"]
  
  # Used for Windows and Linux
  admin_password = data.vault_generic_secret.win_password.data["win_password"]

  # Only for Windows Workgroup to set admin user
  run_once_command_list = [
    # "cmd /c powershell.exe New-LocalUser -Name 'ansible' -Password (ConvertTo-SecureString ${data.vault_generic_secret.win_password.data["win_password"]} -AsPlainText -Force) -FullName 'Ansible' -Description 'Ansible service account'",
    # "cmd /c powershell.exe Add-LocalGroupMember -Group 'Administrators' -Member 'ansible'"
  ]

  vm_ram        = 4096
  vm_cpu        = 2
  vm_base_disk_size_gb = [100] # Comment to use template size
  vm_efi_secure = false

  # vSAN - No Fault Tolerance - Comment for Fault Tolerance (will use default for datastore)
  vsphere_storage_policy_id = "26d71bd1-1bd5-4721-9bfa-ceb3b22e2e30"

  # VMFS Thin Provisioned
  # vsphere_storage_policy_id = "991380e9-8714-4ec0-9c8c-944aa740e8a8"

  dns_server_list = [
    # "10.10.0.10"
    "192.168.1.250",
    "192.168.1.251"
  ]

  data_disk = {
    disk1 = {
      size_gb = 100,
      # thin_provisioned          = false,
      # data_disk_scsi_controller = 0,
      vsphere_storage_policy_id = "26d71bd1-1bd5-4721-9bfa-ceb3b22e2e30" # Must match vm setting

    }
    # disk2 = {
    #   size_gb = 100,
    #   # thin_provisioned          = true,
    #   # data_disk_scsi_controller = 1,
    #   # datastore_id              = "datastore-90679"
    #   vsphere_storage_policy_id = "26d71bd1-1bd5-4721-9bfa-ceb3b22e2e30" # Must match vm setting
    # }
  }
}