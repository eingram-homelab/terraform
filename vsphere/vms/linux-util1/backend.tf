terraform {
  backend "gcs" {
    bucket      = "yc-srv1-tfstate"
    prefix      = "terraform/state/vsphere-linux-util1"
  }
}
