resource "google_compute_network" "vpc_network" {
  name                    = "cloudbox-vpc"
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "web-subnet" {
  name          = "web-subnet"
  region        = var.region
  ip_cidr_range = "10.10.0.0/24"

  network = google_compute_network.vpc_network.id
}


resource "google_compute_instance" "web-server" {
  name         = "web-server"
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["web-server"]

  boot_disk {
    initialize_params {
      image = var.ubuntu_image
    }
  }

metadata_startup_script = <<-EOF
#!/bin/bash
exec > /var/log/my-startup.log 2>&1
set -x

apt-get install -y nginx

echo "Hello from Terraform Lab 1" > /var/www/html/index.html

systemctl enable nginx
systemctl start nginx
EOF

  network_interface {
    subnetwork = google_compute_subnetwork.web-subnet.name

    access_config {
      // Ephemeral public IP
    }
  }
}

resource "google_compute_firewall" "web_rule" {
  name    = "web-rule"
  network = google_compute_network.vpc_network.name


  allow {
    protocol = "tcp"
    ports    = ["80"]
  }


  target_tags   = ["web-server"]
  source_ranges = ["0.0.0.0/0"]
}



