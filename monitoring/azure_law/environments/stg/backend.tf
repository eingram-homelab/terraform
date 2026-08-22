terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "monitoring/azure_law/environments/stg"
  }
}
