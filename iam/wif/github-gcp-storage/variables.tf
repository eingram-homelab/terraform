variable "gcp_project" {
  description = "GCP Project"
  type        = string
}

variable "gcp_region" {
  description = "GCP Region"
  type        = string
  default     = "us-west1"
}

variable "gcp_wip" {
  description = "Workload Identity Pool configuration"
  type = object({
    id                  = string
    display_name        = string
    description         = string
    provider            = string
    attribute_mapping   = optional(map(string))
    attribute_condition = optional(string)
    issuer_uri          = string
    allowed_audiences   = optional(list(string))
  })
}

variable "gcp_service_account" {
  description = "GCP Service Account configuration"
  type = object({
    account_id   = string
    display_name = string
    role         = string
  })
}

variable "gcp_storage_bucket_iam" {
  description = "GCP Storage Bucket IAM configuration"
  type = object({
    bucket = string
    role   = string
  })
}

variable "allowed_repositories" {
  description = "List of allowed GitHub repositories for Workload Identity Federation"
  type        = list(string)
}
