output "vm1_ip" {
  value = google_compute_instance.instance-20250511-075319.network_interface.0.access_config.0.nat_ip
}

output "vm2_ip" {
  value = google_compute_instance.instance-20250511-065329.network_interface.0.access_config.0.nat_ip
}

