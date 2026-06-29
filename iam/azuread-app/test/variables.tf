variable "app_name" {
  description = "Name of the Azure app registration"
  type        = string
}

variable "app_description" {
  description = "Description of the Azure app registration"
  type        = string
  default     = ""
}

variable "tenant_id" {
  description = "AzureAD Tenent ID"
  type = string
  default = ""
}