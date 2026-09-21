terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "vms/vsphere/linux-rke2/vcsa-2/environments/stg"
  }
}
