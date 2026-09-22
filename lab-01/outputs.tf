output "external_ip_web_server" {
  value = "http://${google_compute_instance.web-server.network_interface.0.access_config.0.nat_ip}"
}