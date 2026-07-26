# Module outputs
output "gcp_project" {
  description = "GCP Project"
  value       = module.gcp-wif.gcp_project
}

output "gcp_sa_account_id" {
  description = "GCP Service Account ID"
  value       = module.gcp-wif.gcp_sa_account_id
}

# Full provider string for GitHub Actions
output "github_provider_full_string" {
  description = "Full GitHub OIDC provider string for configuration"
  value       = "projects/${var.gcp_project}/locations/global/workloadIdentityPools/${var.gcp_wip.id}/providers/${var.gcp_wip.provider}"
}

# Workload Identity Pool details
output "workload_identity_pool_id" {
  description = "Workload Identity Pool ID"
  value       = var.gcp_wip.id
}

output "workload_identity_pool_provider_id" {
  description = "Workload Identity Pool Provider ID"
  value       = var.gcp_wip.provider
}

# Service Account details
output "service_account_email" {
  description = "Service account email for GitHub Actions"
  value       = "${var.gcp_service_account.account_id}@${var.gcp_project}.iam.gserviceaccount.com"
}

# Storage bucket IAM
output "storage_bucket_iam_member" {
  description = "Storage bucket IAM member that was created"
  value       = google_storage_bucket_iam_member.member
}

output "storage_bucket_name" {
  description = "Storage bucket name"
  value       = var.gcp_storage_bucket_iam.bucket
}

output "storage_bucket_role" {
  description = "IAM role assigned to the service account on the bucket"
  value       = var.gcp_storage_bucket_iam.role
}

# OIDC Configuration details
output "oidc_issuer_uri" {
  description = "OIDC Issuer URI"
  value       = var.gcp_wip.issuer_uri
}

output "oidc_attribute_mapping" {
  description = "OIDC Attribute Mapping"
  value       = var.gcp_wip.attribute_mapping
}
