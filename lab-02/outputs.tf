output "vm-name" {
  value = google_compute_instance.vm.name
}

output "vm-internal-ip" {
  value = google_compute_instance.vm.network_interface.0.network_ip
}

output "vpc-name" {
  value = data.google_compute_network.vpc.name
}

output "subnet-name" {
  value = data.google_compute_subnetwork.subnet.name
}