data "google_compute_network" "vpc" {
  name = "company-shared-vpc"
}

data "google_compute_subnetwork" "subnet" {
  name   = "backend-subnet"
  region = var.region
}

resource "google_compute_instance" "vm" {
  name         = "backend-server"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["backend"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    }
  }


  network_interface {
    network    = data.google_compute_network.vpc.name
    subnetwork = data.google_compute_subnetwork.subnet.name

  }
}

resource "google_compute_firewall" "rule" {
  name    = "vm-rule"
  network = data.google_compute_network.vpc.name


  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["10.20.0.0/24"]
  target_tags   = ["backend"]

}

