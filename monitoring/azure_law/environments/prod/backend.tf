terraform {
  backend "gcs" {
    bucket = "yc-srv1-tfstate"
    prefix = "container_apps/lib.diversionforum.net/environments/stg"
  }
}
