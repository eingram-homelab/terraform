gcp_project      = "yc-srv1-proj"
vm_name      = "yc-srv1"
machine_type = "e2-small"
image        = "rocky-linux-cloud/rocky-linux-8"

# vcpu = 2
# ram = 1024
boot_disk_size = 20

vpc_name    = "vpc-yc-network1"
subnet_name = "vpc-yc-subnet1"

ip_subnet = "10.100.0.0/24"

# vm_count = 2

# project_service = [
#   "cloudresourcemanager.googleapis.com",
#   "iam.googleapis.com",
#   "compute.googleapis.com",
#   "oslogin.googleapis.com"
# ]