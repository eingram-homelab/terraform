terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "terraform/vms/vsphere/ycd-hv1/vcsa-2/environments/stg"
  }
}
