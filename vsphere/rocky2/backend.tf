terraform {
 backend "gcs" {
   bucket  = "yc-srv1-bucket-tfstate"
   prefix  = "terraform/state/rocky2"
   credentials = "yc-srv1-proj-cd5c053a1b32.json"
 }
}