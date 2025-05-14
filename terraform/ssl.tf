resource "google_compute_region_ssl_certificate" "self_managed" {
  name        = "koala-610-cert"
  region      = var.region
  private_key = file(var.domain_private_key_path)
  certificate = file(var.domain_cert_path)
}

