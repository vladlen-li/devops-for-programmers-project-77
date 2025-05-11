provider "google" {
 project = local.project_id
 region = local.region
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.32.0"
    }
  }
}
