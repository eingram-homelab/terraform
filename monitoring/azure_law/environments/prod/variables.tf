variable "resource_group_name" {
  description = "Existing resource group name where resources will be created"
  type        = string
}

variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

variable "log_analytics_workspace_sku" {
  description = "SKU for the Log Analytics workspace"
  type        = string
}

variable "log_analytics_retention_in_days" {
  description = "Data retention period in days"
  type        = number
}

variable "log_analytics_daily_quota_gb" {
  description = "Daily ingestion quota in GB"
  type        = number
}
