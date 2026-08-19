terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "terraform/state/vsphere/vms/ycd-dc1"
  }
}
