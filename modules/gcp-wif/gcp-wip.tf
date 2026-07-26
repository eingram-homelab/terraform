# Get project number for workload identity principal
resource "google_service_account" "gcp_sa" {
  project      = var.gcp_project
  account_id   = var.gcp_sa_account_id
  display_name = var.gcp_sa_display_name
}

resource "google_iam_workload_identity_pool" "pool" {
  project                   = var.gcp_project
  workload_identity_pool_id = var.gcp_wip_id
  display_name              = var.gcp_wip_display_name
  description               = var.gcp_wip_description
  disabled                  = false
  mode                      = "FEDERATION_ONLY"
}

resource "google_iam_workload_identity_pool_provider" "provider" {
  project                            = var.gcp_project
  depends_on                         = [google_service_account.gcp_sa]
  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.gcp_wip_provider
  display_name                       = var.gcp_wip_provider
  description                        = var.gcp_wip_provider_description
  disabled                           = false
  attribute_condition                = var.gcp_attribute_condition
  attribute_mapping                  = var.gcp_attribute_mapping
  oidc {
    allowed_audiences = var.gcp_allowed_audiences
    issuer_uri        = var.gcp_issuer_uri
  }
}

resource "google_service_account_iam_member" "workload_identity_user" {
  depends_on         = [google_iam_workload_identity_pool_provider.provider]
  for_each           = var.gcp_service_account_iam_members
  service_account_id = "projects/${var.gcp_project}/serviceAccounts/${var.gcp_sa_account_id}@${var.gcp_project}.iam.gserviceaccount.com"
  role               = var.gcp_sa_role
  member             = each.value
}
