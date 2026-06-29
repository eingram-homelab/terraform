variable "az_app_name" {
  description = "Name of the Azure app registration"
  type        = string
}

variable "az_app_description" {
  description = "Description of the Azure app registration"
  type        = string
  default     = "Provide Certbot access to Google DNS for DNS01 auth"
}

variable "gcp_project" {
  description = "GCP Project"
  type        = string
}

variable "gcp_region" {
  description = "GCP Region"
  type        = string
  default     = "us-west1"
}

variable "gcp_services_list" {
  description = "List of GCP APIs to enable"
  type        = list(any)
}

variable "az_tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "gcp_wip" {
  description = "Workload Identity Pool"
  type        = string
}

variable "gcp_wip_description" {
  description = "Workload Identity Pool Description"
  type        = string
  default     = "WIF pool for Azure Entra ID workloads"
}

variable "gcp_wip_provider" {
  description = "GCP Workload Identify Pool Provider ID"
  type        = string
}

variable "gcp_wip_provider_description" {
  description = "GCP Workload Identity Pool Provider Description"
  type        = string
  default     = "Azure Provider"
}

variable "gcp_sa_account_id" {
  description = "Service account ID"
  type        = string
}

variable "gcp_sa_display_name" {
  description = "Service account display name"
  type        = string
  default     = "Service account for certbot-google-dns plugin"
}