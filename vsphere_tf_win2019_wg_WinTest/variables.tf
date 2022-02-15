variable "vsphere_username" {
  default = ""
  sensitive = true
}

variable "vsphere_password" {
  default = ""
  sensitive = true
}

variable "vsphere_server" {
default = "vcsa.local.lan"
}

variable "vm_name" {
}

variable "vm_ram" {
}

variable "vm_cpu" {
}

variable "vsphere_datacenter" {
default = "HomeLab Datacenter"
}

variable "vsphere_compute_cluster" {
default = "Intel NUC10 Cluster"
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

variable "win_password" {
  default = ""
  type = string
  sensitive = true
}
  
variable "ip_address" {
    type = string
    default = ""
}

variable "ip_gateway" {
    type = string
    default = ""
}

variable "dns_server_list" {
    type = list
    default = ["192.168.1.250",
    "192.168.1.251"]
}

variable "dns_suffix_list" {
    type = list
    default = ["local.lan"]
}

variable "full_name" {
    type = string
    default = "Edward Ingram"
}

variable "organization_name" {
    type = string
    default = "HomeLab"
}

variable "time_zone" {
    type = string
    default = "004"
}

variable "workgroup" {
    type = string
    default = "workgroup"
}