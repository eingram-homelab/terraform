terraform {
 backend "gcs" {
   bucket  = "yc-srv1-tfstate"
   prefix  = "terraform/state/HL-TEST1"
   credentials = "~/keys/yc-srv1-proj.json"
 }
}