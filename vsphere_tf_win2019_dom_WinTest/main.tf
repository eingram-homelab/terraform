# Deploy RHEL8.5 VMs

provider "vault" {
}
data "vault_generic_secret" "vsphere_username" {
  path = "secret/vsphere/vcsa"
}
data "vault_generic_secret" "vsphere_password" {
  path = "secret/vsphere/vcsa"
}
data "vault_generic_secret" "win_password" {
  path = "secret/win/administrator"
}

provider "vsphere" {
  user			= data.vault_generic_secret.vsphere_username.data["vsphere_username"]
  password		= data.vault_generic_secret.vsphere_password.data["vsphere_password"]
  vsphere_server 	= var.vsphere_server
  allow_unverified_ssl	= true
}

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_folder" "folder" {
  path             = var.vm_folder
  type             = "vm"
  datacenter_id    = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  count            = 1
  name             = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder
  firmware         = "efi"

  num_cpus = var.vm_cpu
  memory   = var.vm_ram
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  disk {
    label            = "disk1"
    size             = "40"
    unit_number      = 1
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      windows_options {
        computer_name = var.vm_name
        workgroup    = var.workgroup
        admin_password = data.vault_generic_secret.win_password.data["win_password"]
        full_name       = var.full_name
        organization_name = var.organization_name
        auto_logon      = "true"
        time_zone       = var.time_zone
        run_once_command_list = ""
      }

      network_interface {
        ipv4_address = var.ip_address
        ipv4_netmask = 24
      }

      ipv4_gateway = var.ip_gateway
      dns_server_list = var.dns_server_list
      dns_suffix_list = var.dns_suffix_list
    }
  }

  # lifecycle {
  #   prevent_destroy = true
  # }
}


