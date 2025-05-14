terraform {
  backend "gcs" {
    bucket = "terraform-state-bucket-koala610"
    prefix = "terraform/state"
  }
} 