resource "google_compute_instance" "instance-20250511-065329" {
  boot_disk {
    auto_delete = true
    device_name = "instance-20250511-065329"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-12-bookworm-v20250415"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src           = "vm_add-tf"
    goog-ops-agent-policy = "v2-x86-template-1-4-0"
  }

  machine_type = "e2-micro"

  metadata = {
    enable-osconfig = "TRUE"
    ssh-keys        = "vladlen.li:${data.local_file.ssh_key.content}"
  }

  name = "instance-20250511-065329"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = google_compute_subnetwork.public.id
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["http-server", "https-server", "lb-health-check"]
  zone = local.zone
}

module "ops_agent_policy" {
  source        = "github.com/terraform-google-modules/terraform-google-cloud-operations/modules/ops-agent-policy"
  project       = local.project_id
  zone          = local.zone
  assignment_id = "goog-ops-agent-v2-x86-template-1-4-0-us-central1-c"
  agents_rule = {
    package_state = "installed"
    version       = "latest"
  }
  instance_filter = {
    all = false
    inclusion_labels = [
      {
        labels = {
          goog-ops-agent-policy = "v2-x86-template-1-4-0"
        }
      }
    ]
  }
}

resource "google_compute_instance" "instance-20250511-075319" {
  boot_disk {
    auto_delete = true
    device_name = "instance-20250511-075319"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-12-bookworm-v20250415"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src           = "vm_add-tf"
    goog-ops-agent-policy = "v2-x86-template-1-4-0"
  }

  machine_type = "e2-micro"

  metadata = {
    enable-osconfig = "TRUE"
    ssh-keys        = "vladlen.li:${data.local_file.ssh_key.content}"
  }

  name = "instance-20250511-075319"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = google_compute_subnetwork.public.id
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["http-server", "https-server", "lb-health-check"]
  zone = local.zone
}

resource "google_compute_instance_group" "study_application_group" {
  name    = "study-application-group"
  zone    = local.zone
  network = google_compute_network.vpc.self_link
  instances = [
    google_compute_instance.instance-20250511-065329.self_link,
    google_compute_instance.instance-20250511-075319.self_link
  ]
}

