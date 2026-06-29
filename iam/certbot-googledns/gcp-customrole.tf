resource "google_project_iam_custom_role" "gcp_custom_role" {
  role_id     = "certbot_dns"
  title       = "Certbot DNS Role"
  description = "Custom role for certbot-google-dns plugin"
  permissions = [
    "dns.changes.create",
    "dns.changes.get",
    "dns.changes.list",
    "dns.managedZones.get",
    "dns.managedZones.list",
    "dns.resourceRecordSets.create",
    "dns.resourceRecordSets.delete",
    "dns.resourceRecordSets.get",
    "dns.resourceRecordSets.list",
  ]
}


