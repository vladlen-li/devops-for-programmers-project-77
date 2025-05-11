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
    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.35" 
    }
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = "https://api.datadoghq.eu/"
}

