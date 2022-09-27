terraform {
 backend "gcs" {
   bucket  = "yc-srv1-tfstate"
   prefix  = "terraform/state/CHANGENAME"
   credentials = "~/keys/yc-srv1-proj.json"
 }
}