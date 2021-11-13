# Deploy CentOS7 VM

variable "vsphere_password" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "ip_address" {
  type = string
}

provider "vsphere" {
  user			= "administrator@vsphere.local"
  password		= var.vsphere_password
  vsphere_server 	= "vcsa.local.lan"
  allow_unverified_ssl	= true
}

data "vsphere_datacenter" "dc" {
  name = "HomeLab Datacenter"
}

data "vsphere_datastore" "datastore" {
  name          = "XN_iSCSI_SSD2"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "Intel NUC10 Cluster"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "Lab-LAN1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "TMP-Centos7_Packer_2021_11"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 2
  memory   = 4096
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = var.vm_name
        domain    = "local.lan"
      }

      network_interface {
        ipv4_address = var.ip_address
        ipv4_netmask = 24
      }

      ipv4_gateway = "10.10.0.1"
    }
  }
}
