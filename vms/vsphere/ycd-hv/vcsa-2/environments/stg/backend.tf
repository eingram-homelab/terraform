terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "vms/vsphere/ycd-hv/vcsa-2/environments/stg"
  }
}
