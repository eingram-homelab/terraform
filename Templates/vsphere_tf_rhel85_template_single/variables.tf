variable "vsphere_username" {
  default = ""
  sensitive = true
}

variable "vsphere_password" {
  default = ""
  sensitive = true
}

variable "vsphere_server" {
default = ""
}

variable "vm_name" {
}

variable "vm_ram" {
}

variable "vm_cpu" {
}

variable "vsphere_datacenter" {
default = ""
}

variable "vsphere_compute_cluster" {
default = ""
}

variable "vsphere_datastore" {
default = ""
}

variable "vsphere_template" {
    default = ""
}

variable "vm_folder" {
default = ""
}

variable "esxi_hosts" {
default = []
}
 
variable "network_interfaces" {
description = "vmnics to be used" 
default = []
}

variable "vsphere_network" {
default = ""
}

variable "port_group_name" {
default = ""
}

variable "vsphere_dvs" {
  default = ""

}
variable "iso_path" {
  default = ""
}

variable "vsphere_hardware_version" {
  default = ""

}

variable "ssh_username" {
  default = ""
  type = string
  sensitive = true
}
variable "ssh_password" {
  default = ""
  type = string
  sensitive = true
}

variable "sub_email" {
  default = ""
  type = string
  sensitive = true
}

variable "sub_password" {
  default = ""
  type = string
  sensitive = true
}
  
variable "ip_address" {
    type = string
    default = ""
}

variable "dns_server_list" {
    type = list
    default = []
}

variable "dns_suffix_list" {
    type = list
    default = []
}

variable "ansible_group" {
    type = string
    default = ""
}