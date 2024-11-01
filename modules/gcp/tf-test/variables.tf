variable "project" {}

variable "credentials_file" {
  default = "tf-test-347000-3ca8fbe22dbb.json"
}

variable "region" {
  default = "us-west1"
}

variable "zone" {
  default = "us-west1-c"
}

variable "vm_name" {}

variable "vpc_name" {}

variable "machine_type" {}

variable "image" {}

variable "ip_subnet" {}

variable "subnet_name" {}

variable "vm_count" {}

variable "project_service" {}