terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.9"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

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
  name    = "yc-firewall"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.machine_type

  metadata = {
    enable-oslogin = "TRUE"
  }

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.boot_disk_size
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.name
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  # lifecycle {
  #   prevent_destroy = true
  # }

}

output "external_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
