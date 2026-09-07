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

variable "app_name" {
  description = "Base name used to compose network and app resource names"
  type        = string
  default     = "example-app"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
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

variable "dns_servers" {
  description = "DNS servers for the virtual network"
  type        = list(string)
  default     = ["10.0.0.4", "10.0.0.5"]
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "security_rules" {
  description = "Network security rules for the NSG, keyed by rule name"
  type = map(object({
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_ranges    = list(string)
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = {}
}

variable "log_analytics_workspace_sku" {
  description = "SKU for the Log Analytics workspace used by the container app environment"
  type        = string
  default     = "PerGB2018"
}

variable "container_app_environment" {
  description = "Container App environment settings"
  type = object({
    workload_profile_name = string
    workload_profile_type = string
    internal_load_balancer_enabled = bool
    public_network_access = string
  })
  default = {
    workload_profile_name = "Consumption"
    workload_profile_type = "Consumption"
    internal_load_balancer_enabled = false
    public_network_access = "Disabled"
  }
}

variable "container_app" {
  description = "Container App settings"
  type = object({
    image                           = string
    cpu                             = string
    memory                          = string
    revision_mode                   = string
    max_replicas                    = number
    min_replicas                    = number
    cooldown_period_in_seconds      = number
    polling_interval_in_seconds     = number
    ingress = object({
      external_enabled              = bool
      target_port                   = number
      allow_insecure_connections    = bool
    })
  })
  default = {
    image                       = "nginx:latest"
    cpu                         = "0.5"
    memory                      = "1.0Gi"
    revision_mode               = "Single"
    max_replicas               = 1
    min_replicas               = 0
    cooldown_period_in_seconds  = 300
    polling_interval_in_seconds = 30
    ingress = {
      external_enabled           = true
      target_port                = 80
      allow_insecure_connections = true
    }
  }
}

variable "tags" {
  description = "Tags applied to resources"
  type        = map(string)
  default     = {}
}

# variable "storage_account_name" {
#   description = "Name of the storage account backing the file shares (globally unique, lowercase alphanumeric, 3-24 chars). Required only if file_shares is non-empty."
#   type        = string
#   default     = ""
# }

# variable "file_shares" {
#   description = "Azure File shares to create and mount into the container app, keyed by share name"
#   type = map(object({
#     quota_gb   = number
#     mount_path = string
#   }))
#   default = {}
# }