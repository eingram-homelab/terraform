project      = "tf-test-347000"
vm_name      = "tf-test-vm"
machine_type = "f1-micro"
image        = "debian-cloud/debian-9"

vpc_name    = "tf-test-network1"
subnet_name = "tf-test-subnet1"

ip_subnet = "10.30.0.0/24"

vm_count = 2

project_service = [
  "cloudresourcemanager.googleapis.com",
  "iam.googleapis.com",
  "compute.googleapis.com",
  "oslogin.googleapis.com"
]