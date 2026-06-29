resource "google_iam_workload_identity_pool" "pool" {
  workload_identity_pool_id = var.gcp_wip
  display_name              = var.gcp_wip
  description               = var.gcp_wip_description
  disabled                  = false
  mode                      = "FEDERATION_ONLY"
}

resource "google_iam_workload_identity_pool_provider" "provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.gcp_wip_provider
  display_name                       = var.gcp_wip_provider
  description                        = var.gcp_wip_provider_description
  disabled                           = false
  attribute_condition                = "assertion.tid == '${var.az_tenant_id}'"
  attribute_mapping = {
    "google.subject"   = "assertion.sub"
    "attribute.tenant" = "assertion.tid"
  }
  oidc {
    allowed_audiences = ["api://${azuread_application_registration.az_app.client_id}"]
    issuer_uri        = "https://sts.windows.net/${var.az_tenant_id}/"
  }
}