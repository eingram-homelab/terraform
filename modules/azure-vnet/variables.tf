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

variable "subnets" {
  description = "Subnets for the virtual network, keyed by subnet name"
  type = map(object({
    address_prefixes = list(string)
  }))
  default = {
    example-subnet = {
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}

variable "security_rules" {
  description = "Security rules for the network security group, keyed by rule name"
  type        = map(object({
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = optional(string)
    source_port_ranges         = optional(list(string))
    destination_port_range     = optional(string)
    destination_port_ranges    = optional(list(string))
    source_address_prefix      = optional(string)
    source_address_prefixes     = optional(list(string))
    destination_address_prefix = optional(string)
    destination_address_prefixes = optional(list(string))
  }))
  default     = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}