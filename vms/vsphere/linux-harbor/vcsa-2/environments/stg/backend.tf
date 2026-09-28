terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "vms/vsphere/linux-harbor/vcsa-2/environments/stg"
  }
}
