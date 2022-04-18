terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}

# resource "google_project_service" "project" {
#   for_each = toset(var.project_service)
#   service  = each.key

#   lifecycle {
#     prevent_destroy = true
#   }
# }

resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = var.ip_subnet
}

resource "google_compute_firewall" "firewall" {
  name    = "default-rules"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_instance" "vm_instance" {
  count        = var.vm_count
  name         = "${var.vm_name}${count.index + 1}"
  machine_type = var.machine_type
  metadata = {
    enable-oslogin = "TRUE"
  }

  boot_disk {
    initialize_params {
      # size  = var.boot_disk_size
      image = var.image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.name
    access_config {
    }
  }
}