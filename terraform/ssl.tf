resource "google_compute_region_ssl_certificate" "self_managed" {
  name = "koala-610-cert"
  region = local.region
  private_key = file("/home/koala/domain/domain.key")
  certificate = file("/home/koala/domain/domain.crt")
}

