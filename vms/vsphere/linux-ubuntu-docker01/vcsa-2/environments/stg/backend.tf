terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "vms/vsphere/linux-ubuntu-docker01/vcsa-2/environments/stg"
  }
}
