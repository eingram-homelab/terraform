gcp_wip = {
  id           = "github-actions-wip"
  display_name = "GitHub Actions Pool"
  description  = "Workload Identity Pool for GitHub Actions"
  provider     = "github-actions-provider"
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.aud"              = "assertion.aud"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  attribute_condition = "attribute.repository == assertion.repository && attribute.repository_owner == assertion.repository_owner"
  issuer_uri          = "https://token.actions.githubusercontent.com"
  # allowed_audiences = ["api://github-actions"]
}

gcp_service_account = {
  account_id   = "github-actions-gcs"
  display_name = "Service account for GitHub Actions GCS access"
  role         = "roles/iam.workloadIdentityUser"
}

gcp_storage_bucket_iam = {
  bucket = "yc-srv1-tfstate"
  role   = "roles/storage.objectAdmin"
}

allowed_repositories = [
  "eingram-homelab/reusable-workflows"
]
