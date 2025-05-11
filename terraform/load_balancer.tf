resource "google_compute_region_health_check" "http" {
  name   = "http-health-check"
  region = local.region

  http_health_check {
    port         = 80
    request_path = "/"
  }
}

resource "google_compute_region_backend_service" "study_backend" {
  name                            = "study-backend"
  region                          = local.region
  protocol                        = "HTTP"
  load_balancing_scheme           = "EXTERNAL_MANAGED"
  health_checks                   = [google_compute_region_health_check.http.id]
  timeout_sec                     = 30
  connection_draining_timeout_sec = 300

  backend {
    group = google_compute_instance_group.study_application_group.self_link
    capacity_scaler  = 1.0
  }
}

resource "google_compute_region_url_map" "urlmap" {
  name            = "study-url-map"
  region          = local.region
  default_service = google_compute_region_backend_service.study_backend.id
}

resource "google_compute_region_target_https_proxy" "https_proxy" {
  name             = "study-https-proxy"
  region           = local.region
  url_map          = google_compute_region_url_map.urlmap.id
  ssl_certificates = [google_compute_region_ssl_certificate.self_managed.id]
}

resource "google_compute_forwarding_rule" "https" {
  name                  = "https-forwarding-rule"
  region                = local.region
  target                = google_compute_region_target_https_proxy.https_proxy.id
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "443"
  ip_protocol           = "TCP"
  network_tier          = "PREMIUM"
  network = google_compute_network.vpc.id
  depends_on = [google_compute_subnetwork.proxy_only]
}
