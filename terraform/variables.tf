variable "datadog_api_key" {
  description = "Datadog API key"
  type        = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "Datadog Application key"
  type        = string
  sensitive   = true
}

variable "domain_private_key_path" {
  description = "Certificate private key path"
  type        = string
}

variable "domain_cert_path" {
  description = "Certificate path"
  type        = string
}

variable "ssh_pub_key_path" {
  description = "Certificate path"
  type        = string
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "zone" {
  description = "The GCP zone"
  type        = string
}

variable "apis" {
  description = "List of GCP APIs to enable"
  type        = list(string)
  default     = [
    "compute.googleapis.com",
    "logging.googleapis.com"
  ]
}
