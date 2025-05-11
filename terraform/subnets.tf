resource "google_compute_subnetwork" "public" {
  name = "public"
  ip_cidr_range = "10.0.0.0/19"
  region = local.region
  network = google_compute_network.vpc.id
  stack_type = "IPV4_ONLY"
}

resource "google_compute_subnetwork" "proxy_only" {
  name = "proxy-only-subnet"
  ip_cidr_range = "10.0.32.0/19"
  region = local.region
  network = google_compute_network.vpc.id
  purpose       = "REGIONAL_MANAGED_PROXY"
  stack_type = "IPV4_ONLY"
  role          = "ACTIVE"
}
