variable "vm_name" {
  description = "Name of the virtual machine."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the VM and network resources are located."
  type        = string
}

variable "location" {
  description = "Azure location/region for created resources. If null, the resource group's location is used."
  type        = string
  default     = null
}

variable "image" {
  description = "Marketplace image reference for the VM."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "vm_size" {
  description = "Azure VM size (for example, Standard_B2s)."
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "Storage account type for the OS disk."
  type        = string
  default     = "Standard_LRS"
}

variable "vnet_name" {
  description = "Name of the virtual network to use or create."
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet to use or create in the virtual network."
  type        = string
}

variable "create_vnet" {
  description = "When true, create the VNet and subnet. When false, use existing ones."
  type        = bool
  default     = false
}

variable "vnet_address_space" {
  description = "Address space for a new VNet when create_vnet is true."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for a new subnet when create_vnet is true."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "network_interface_name" {
  description = "Optional NIC name. If null, defaults to <vm_name>-nic."
  type        = string
  default     = null
}

variable "private_ip_address" {
  description = "Optional static private IP for the NIC. If null, dynamic allocation is used."
  type        = string
  default     = null
}

variable "admin_username" {
  description = "Admin username for the virtual machine."
  type        = string
}

variable "tags" {
  description = "Optional tags applied to created resources."
  type        = map(string)
  default     = {}
}

variable "public_key" {
  description = "Public SSH key for the admin user."
  type        = string
}

variable "cloud_init" {
  description = "Optional cloud-init YAML content. If null, no custom_data is sent to the VM."
  type        = string
  default     = null
}

variable "enable_waagent_extension" {
  description = "Install/ensure waagent on Linux VM using Custom Script extension."
  type        = bool
  default     = true
}

variable "enable_monitor_agent_extension" {
  description = "Install Azure Monitor Agent extension on Linux VM."
  type        = bool
  default     = true
}