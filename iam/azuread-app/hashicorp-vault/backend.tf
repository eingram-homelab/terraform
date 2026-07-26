terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "terraform/state/hashicorp-vault/vault.ycdisp.net"
  }
}
