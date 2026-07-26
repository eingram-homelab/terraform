terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "terraform/state/azure-key-vault/vault.ycdisp.net"
  }
}
