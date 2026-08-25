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

# variable "infrastructure_subnet_id" {
#   description = "ID of the subnet for the container app environment"
#   type        = string
#   default     = ""
# }

variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace for the container app environment"
  type        = string
  default     = ""
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

# variable "volume_mounts" {
#   description = "Azure File shares to mount into the container app, keyed by volume name"
#   type = map(object({
#     storage_account_name = string
#     storage_account_key  = string
#     share_name           = string
#     access_mode          = optional(string, "ReadWrite")
#     mount_path           = string
#   }))
#   default   = {}
#   sensitive = true
# }