provider "google" {
  # credentials = file(var.credentials_file)
  credentials = file(var.credentials_file)
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

resource "google_storage_bucket" "default" {
  name          = var.bucket_name
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = false
  }
}

terraform {
 backend "gcs" {
   bucket  = "yc-srv1-bucket-tfstate"
   prefix  = "terraform/state"
   credentials = "yc-srv1-proj-cd5c053a1b32.json"
 }
}