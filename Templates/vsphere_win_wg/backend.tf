terraform {
 backend "gcs" {
   bucket  = "yc-srv1-bucket-tfstate"
   prefix  = "terraform/state/CHANGENAME"
   credentials = "creds.json"
 }
}