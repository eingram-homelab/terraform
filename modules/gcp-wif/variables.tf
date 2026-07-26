variable "gcp_project" {
  description = "GCP Project"
  type        = string
}

variable "gcp_region" {
  description = "GCP Region"
  type        = string
  default     = "us-west1"
}

variable "gcp_wip_id" {
  description = "Workload Identity Pool"
  type        = string
}

variable "gcp_wip_display_name" {
  description = "Workload Identity Pool Display Name"
  type        = string
}

variable "gcp_wip_description" {
  description = "Workload Identity Pool Description"
  type        = string
  default     = ""
}

variable "gcp_wip_provider" {
  description = "GCP Workload Identify Pool Provider ID"
  type        = string
}

variable "gcp_wip_provider_description" {
  description = "GCP Workload Identity Pool Provider Description"
  type        = string
  default     = ""
}

variable "gcp_sa_account_id" {
  description = "Service account ID"
  type        = string
}

variable "gcp_sa_display_name" {
  description = "Service account display name"
  type        = string
  default     = ""
}

variable "gcp_sa_role" {
  description = "Service account role"
  type        = string
  default     = ""
}

variable "gcp_attribute_mapping" {
  description = "Attribute mappings for the Workload Identity Pool Provider"
  type        = map(string)
  default     = {}
}

variable "gcp_attribute_condition" {
  description = "Attribute condition for the Workload Identity Pool Provider"
  type        = string
  default     = ""
}

variable "gcp_issuer_uri" {
  description = "Issuer URI for the Workload Identity Pool Provider"
  type        = string
  default     = ""
}

variable "gcp_allowed_audiences" {
  description = "Allowed audiences for the Workload Identity Pool Provider"
  type        = list(string)
  default     = []
}

variable "gcp_service_account_iam_members" {
  description = "IAM members for the service account"
  type        = map(string)
  default     = {}
}
