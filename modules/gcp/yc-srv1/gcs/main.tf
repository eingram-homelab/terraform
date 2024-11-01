provider "google" {
  credentials = file(var.credentials_file)
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

resource "google_storage_bucket" "default" {
  name          = "yc-srv1-tfstate-test"
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = false
  }
}

terraform {
 backend "gcs" {
   bucket  = var.bucket_name
   prefix  = "terraform/state/"
   credentials = "yc-srv1-proj-cd5c053a1b32.json"
 }
}