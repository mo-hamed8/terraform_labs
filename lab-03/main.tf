resource "google_compute_network" "vpc" {
  name                    = "state-lab-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "state-lab-subnet"
  ip_cidr_range = "10.30.0.0/24"
  network       = google_compute_network.vpc.id
  region        = var.region
}



# moved {
#   from = google_compute_instance.vm
#   to = google_compute_instance.backend_vm
# }

# removed {
#   from = google_compute_instance.backend_vm
#   lifecycle {
#     destroy = false
#   }
# }

# import {
#   to = google_compute_instance.backend_vm
#   id = "projects/chaos-508903/zones/me-central1-a/instances/state-lab-vm"
# }

resource "google_compute_instance" "backend_vm" {
  name         = "state-lab-vm"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["manual-change"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet.id

  }
}