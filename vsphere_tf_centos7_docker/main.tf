# Deploy CentOS7 VMs

provider "vault" {
}
data "vault_generic_secret" "vsphere_username" {
  path = "secret/vsphere/vcsa"
}
data "vault_generic_secret" "vsphere_password" {
  path = "secret/vsphere/vcsa"
}
data "vault_generic_secret" "ssh_username" {
  path = "secret/ssh/eingram"
}
data "vault_generic_secret" "ssh_password" {
  path = "secret/ssh/eingram"
}

provider "vsphere" {
  user			= "${data.vault_generic_secret.vsphere_username.data["vsphere_username"]}"
  password		= "${data.vault_generic_secret.vsphere_password.data["vsphere_password"]}"
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

  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "null_resource" "pihole_customlist_copy" {
  provisioner "local-exec" {
    command = <<-EOT
      ansible-playbook ../../Ansible/playbooks/terraform/tf_update_pihole.yaml
    EOT
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

  # lifecycle {
  #   prevent_destroy = true
  # }

  provisioner "file" {
    source       = "~/code/Terraform/files/post_script.sh"
    destination  = "/home/eingram/post_script.sh"
  }

    connection {
      type        = "ssh"
      agent       = false
      host        = self.clone.0.customize.0.network_interface.0.ipv4_address
      user        = "${data.vault_generic_secret.ssh_username.data["ssh_username"]}"
      password    = "${data.vault_generic_secret.ssh_password.data["ssh_password"]}"

    }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/eingram/post_script.sh",
      "echo ${data.vault_generic_secret.ssh_password.data["ssh_password"]} | sudo -S /home/eingram/post_script.sh",
      "mkdir ~/.ssh",
      "chmod 755 ~/.ssh",
      "touch ~/.ssh/authorized_keys",
      "chmod 600 ~/.ssh/authorized_keys",
      "echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClXgpzukaegu/puhLlf3omPF09pISe0S6VqKblMidQA9z0Uyn3aThsrtZJvokirlCm5zDPuqKkZ8GHsot2bonLnwLzfv+5wFANEaJzLL9WbH8SmoqHyAOVkmEzXcNCimHCsrfkWMID5klft4dPt0oULcAmvYEKlwvPqpm6kvQs2hDU8VEVGBDKYytSKbAbijJDz1cJBCkJAP9IKcGW6Q/RiWuetzzO2nGvCdX4H94Y66DO60zLPokbV+oeFrKnMcAHL4OZ+LxCAN61mMyXYDk4Yb8vxD8q8WF+6ncQBYZaEgBk0jQUHwfDCnQ4KwO8UTuI8OMB/9Iq2glSjVhmi/OY7LbbO/dYYCPQkcC/UkG4TQmJGsNlsyEyyeFof9zvTLQsS6QJjz6ru6ezRa5+roXifh7pbDe5L0rGW8InOieUxnH+J0I6kgEFkdP8r4gdrpu4HNiqqQ4A0e79kU8iH+tk3bkRxNbGllhtrVUt4dLgQOqYkHql7oB3POD9sAQGZA0= edwardingram@MacBook-Pro.local.lan' >> ~/.ssh/authorized_keys"
    ]

    connection {
      type        = "ssh"
      agent       = false
      host        = self.clone.0.customize.0.network_interface.0.ipv4_address
      user        = "${data.vault_generic_secret.ssh_username.data["ssh_username"]}"
      password    = "${data.vault_generic_secret.ssh_password.data["ssh_password"]}"

    }
  }

  provisioner "local-exec" {
    command = <<-EOT
      ansible-playbook ../../Ansible/playbooks/terraform/tf_deploy_new_server.yaml --extra-vars "newhost=${var.vm_name}${count.index+1}.local.lan newip=${element(var.ip_address_list, count.index)}"
    EOT
  }
}

resource "null_resource" "pihole_update" {
  provisioner "local-exec" {
    command = <<-EOT
      ansible-playbook ../../Ansible/playbooks/terraform/tf_update_pihole.yaml
    EOT
  }
}
