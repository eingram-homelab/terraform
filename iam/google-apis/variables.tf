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
