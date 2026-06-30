resource "google_project_service" "gcp_services" {
  for_each = toset(var.gcp_services_list)
  project  = var.gcp_project
  service  = each.value

  timeouts {
    create = "5m"
    update = "10m"
  }
}