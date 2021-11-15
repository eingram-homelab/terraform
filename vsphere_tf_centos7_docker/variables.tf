variable "vsphere_user" {
    default = ""
}

variable "vsphere_password" {
}

variable "vsphere_server" {
default = ""
}

variable "vm_name" {
    default = ""
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

variable "ssh_password" {
  type = string
}
  
variable "ip_address_list" {
    type = list
    default = []
}

variable "dns_server_list" {
    type = list
    default = []
}

variable "dns_suffix_list" {
    type = list
    default = []
}