resource "google_service_account" "certbot_dns" {
  account_id   = "certbot-dns"
  display_name = "Service account for certbot-google-dns plugin"
}

resource "google_project_iam_member" "certbot_dns" {
  project = "proj-yc-srv1"
  role    = google_project_iam_custom_role.certbot_dns.name
  member  = "serviceAccount:${google_service_account.certbot_dns.email}"
}