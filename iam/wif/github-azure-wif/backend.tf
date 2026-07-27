terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "terraform/state/wif/github-gcp-storage"
  }
}
