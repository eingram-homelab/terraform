terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
  }
}
