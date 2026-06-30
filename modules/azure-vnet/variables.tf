variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "West Europe"
}

variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
  default     = "example-security-group"
}

variable "ssh_source_address" {
  description = "Source address prefix allowed for SSH access"
  type        = string
  default     = "*"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "example-network"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "dns_servers" {
  description = "DNS servers for the virtual network"
  type        = list(string)
  default     = ["10.0.0.4", "10.0.0.5"]
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "subnet1"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "Production"
}
