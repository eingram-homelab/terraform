terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "vms/vsphere/win11-pc"
  }
}
