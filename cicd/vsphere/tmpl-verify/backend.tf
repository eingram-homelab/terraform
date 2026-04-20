terraform {
  backend "gcs" {
    bucket      = "yc-srv1-tfstate"
    credentials = "/tmp/cred.json"
    prefix      = "terraform/state/vsphere-vm-test"
  }
}
