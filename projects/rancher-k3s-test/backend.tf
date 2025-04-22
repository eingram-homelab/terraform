terraform {
  backend "gcs" {
    bucket      = "yc-srv1-tfstate"
    credentials = "/Users/edwardingram/keys/gcp_bucket_tfstate.json"
    prefix      = "terraform/state/rancher-k3s-test"
  }
}
