resource "google_compute_firewall" "allow_ssh" {
  name = "allow-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_http" {
  name = "allow-http"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_webserver_port" {
  name = "allow-webserver-port"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports = ["3000"]
  }
  source_ranges = ["0.0.0.0/0"]
}
