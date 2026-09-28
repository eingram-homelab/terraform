terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "vms/vsphere/linux-haproxy2/vcsa-2/environments/stg"
  }
}
