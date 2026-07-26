variable "app_name" {
  description = "Name of the Azure app registration"
  type        = string
}

variable "app_description" {
  description = "Description of the Azure app registration"
  type        = string
  default     = ""
}

variable "app_password" {
  description = "Whether to create a password for the Azure app registration"
  type        = bool
  default     = false
}

variable "tenant_id" {
  description = "AzureAD Tenant ID"
  type        = string
  default     = ""
}

variable "service_principal_name" {
  description = "Name of the Azure service principal"
  type        = string
  default     = ""
}

variable "redirect_uris" {
  description = "Redirect URIs for the application"
  type        = list(string)
  default     = []
}

variable "redirect_uri_type" {
  description = "Type of the redirect URIs for the application"
  type        = string
  default     = ""
}
