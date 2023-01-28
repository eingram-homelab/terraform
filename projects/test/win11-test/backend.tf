terraform {
 backend "gcs" {
   bucket  = "yc-srv1-tfstate"
   prefix  = "terraform/state/win11-test"
   credentials = "~/keys/yc-srv1-proj.json"
 }
}