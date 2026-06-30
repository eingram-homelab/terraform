resource "google_service_account" "gcp_sa" {
  account_id   = var.gcp_sa_account_id
  display_name = var.gcp_sa_display_name
}

# Get project number for workload identity principal
data "google_project" "project" {
  project_id = var.gcp_project
}

# Assign DNS role for DNS01 ACME challenge
# Allows: list zones, create/modify/delete DNS records
resource "google_project_iam_member" "dns_role" {
  project = var.gcp_project
  role    = google_project_iam_custom_role.gcp_custom_role.name
  member  = "serviceAccount:${google_service_account.gcp_sa.email}"
}

# Allow Azure service principal to impersonate this service account via Workload Identity
resource "google_service_account_iam_member" "workload_identity_user" {
  service_account_id = google_service_account.gcp_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principal://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.pool.workload_identity_pool_id}/subject/${azuread_service_principal.az_app.object_id}"
}
