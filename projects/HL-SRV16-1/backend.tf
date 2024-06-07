terraform {
  backend "gcs" {
    bucket      = "yc-srv1-tfstate"
    prefix      = "terraform/state/HL-SRV16-1"
    credentials = "~/keys/yc-srv1-proj.json"
  }
}