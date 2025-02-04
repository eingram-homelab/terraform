terraform {
    backend "gcs" {
        bucket      = "yc-srv1-tfstate"
        credentials = "/Users/edwardingram/keys/gcp_storage.json"
        prefix      = "terraform/state/rancher-k3s-mgmt-1"
    }
}
