variable "gcp_project" {}

variable "credentials_file" {
  default = "yc-srv1-proj-cd5c053a1b32.json"
}

variable "gcp_region" {
  default = "us-west1"
}

variable "gcp_zone" {
  default = "us-west1-a"
}

variable "vm_name" {}

variable "vpc_name" {}

variable "machine_type" {}

variable "image" {}

variable "ip_subnet" {}

variable "subnet_name" {}

# variable "vm_count" {}

# variable "project_service" {}

variable "boot_disk_size" {}