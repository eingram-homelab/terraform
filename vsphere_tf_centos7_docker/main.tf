# Deploy CentOS7 Docker VMs (3)

provider "vsphere" {
  user			= "administrator@vsphere.local"
  password		= "${var.vsphere_password}"
  vsphere_server 	= "${var.vsphere_server}"
  allow_unverified_ssl	= true
}

data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.vsphere_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vsphere_compute_cluster}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vsphere_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_folder" "folder" {
  path             = "${var.vm_folder}"
  type             = "vm"
  datacenter_id    = "${data.vsphere_datacenter.dc.id}"

  lifecycle {
    prevent_destroy = true
  }
}

resource "vsphere_virtual_machine" "docker" {
  count            = length(var.ip_address_list)
  name             = "${var.vm_name}${count.index+1}"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  folder           = "${var.vm_folder}"

  num_cpus = 1
  memory   = 1024
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
        host_name = "${var.vm_name}${count.index+1}"
        domain    = "local.lan"
      }

      network_interface {
        ipv4_address = element(var.ip_address_list, count.index)
        ipv4_netmask = 24
      }

      ipv4_gateway = "10.10.0.1"
      dns_server_list = "${var.dns_server_list}"
      dns_suffix_list = "${var.dns_suffix_list}"
    }
  }

  lifecycle {
    prevent_destroy = true
  }

  # We run this to make sure server is initialized before we run the "local exec"
  provisioner "remote-exec" {
    inline = ["echo 'Waiting for server to be initialized...'"]

    connection {
      type        = "ssh"
      agent       = false
      host        = self.private_ip
      user        = "eingram"
      password    = "${var.ssh_password}"

    }
  }

  provisioner "local-exec" {
    command = ansible-playbook ~/Ansible/playbooks/deploy_new_server.yaml -kK --extra-vars 'newhost="${var.vm_name}${count.index+1}.local.lan"'
  }
}