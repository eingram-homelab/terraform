terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "terraform/vms/vsphere/linux-rke2/environments/stg"
  }
}
