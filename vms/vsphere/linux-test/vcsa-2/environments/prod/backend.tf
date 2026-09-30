terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "vms/vsphere/linux-test/vcsa-2/environments/prod"
  }
}
