# GCP Configuration
locals {
  gcp_service_account_iam_members = {
    for repo in var.allowed_repositories : repo => "principalSet://iam.googleapis.com/projects/433507715827/locations/global/workloadIdentityPools/${var.gcp_wip.id}/attribute.repository/${repo}"
  }
}

module "gcp-wif" {
  source = "../../../modules/gcp-wif"

  gcp_project                     = var.gcp_project
  gcp_region                      = var.gcp_region
  gcp_wip_id                      = var.gcp_wip.id
  gcp_wip_display_name            = var.gcp_wip.display_name
  gcp_wip_description             = var.gcp_wip.description
  gcp_wip_provider                = var.gcp_wip.provider
  gcp_sa_account_id               = var.gcp_service_account.account_id
  gcp_sa_display_name             = var.gcp_service_account.display_name
  gcp_sa_role                     = var.gcp_service_account.role
  gcp_attribute_mapping           = var.gcp_wip.attribute_mapping
  gcp_attribute_condition         = var.gcp_wip.attribute_condition
  gcp_issuer_uri                  = var.gcp_wip.issuer_uri
  gcp_allowed_audiences           = var.gcp_wip.allowed_audiences
  gcp_service_account_iam_members = local.gcp_service_account_iam_members
}

resource "google_storage_bucket_iam_member" "member" {
  depends_on = [module.gcp-wif]
  bucket     = var.gcp_storage_bucket_iam.bucket
  role       = var.gcp_storage_bucket_iam.role
  member     = "serviceAccount:${var.gcp_service_account.account_id}@${var.gcp_project}.iam.gserviceaccount.com"
}
