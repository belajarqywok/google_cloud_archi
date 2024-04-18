# Compute Address
resource "google_compute_address" "compute_address" {
  name       = "${var.instance_template_name}-ipv4-address"
  region     = var.instance_template_region

  ip_version   = "IPV4"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
}

# Instance Template
resource "google_compute_instance_template" "instance_template" {
  name        = var.instance_template_name
  description = var.instance_template_description

  region       = var.instance_template_region
  machine_type = var.instance_template_machine_type

  tags = var.instance_template_tags

  scheduling {
    provisioning_model  = var.instance_template_scheduling.provisioning_model
    on_host_maintenance = var.instance_template_scheduling.on_host_maintenance
    automatic_restart   = var.instance_template_scheduling.automatic_restart
  }

  disk {
    source      = google_compute_disk.instance_compute_disk.name
    auto_delete = var.instance_template_disk.auto_delete
    boot        = var.instance_template_disk.boot

    resource_policies = [
      google_compute_resource_policy.instance_compute_disk_policy.id
    ]
  }

  network_interface {
    network    = var.instance_template_net_interface.network
    subnetwork = var.instance_template_net_interface.subnetwork
    stack_type = var.instance_template_net_interface.stack_type

    access_config {
      nat_ip = google_compute_address.compute_address.address
    }
  }

  service_account {
    email  = "${
      data.google_compute_default_service_account.default_service_account.email
    }"

    scopes = [ "cloud-platform" ]
  }

  metadata = var.instance_template_metadata
  metadata_startup_script = var.instance_template_startup_script
}

# Instance Compute Image
data "google_compute_image" "instance_compute_image" {
  family  = var.instance_template_disk.disk_source.image.family
  project = var.instance_template_disk.disk_source.image.project
}

# Instance Compute Disk
resource "google_compute_disk" "instance_compute_disk" {
  name  = var.instance_template_disk.disk_source.name
  image = data.google_compute_image.instance_compute_image.self_link
  size  = var.instance_template_disk.disk_source.size
  type  = var.instance_template_disk.disk_source.type
  zone  = var.instance_template_disk.disk_source.zone
}

# Instance Compute Disk Policy
resource "google_compute_resource_policy" "instance_compute_disk_policy" {
  name   = var.instance_template_disk.policy.name
  region = var.instance_template_disk.policy.region

  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        start_time    = var.instance_template_disk.policy.start_time
        days_in_cycle = var.instance_template_disk.policy.days_in_cycle
      }
    }
  }
}

# Instance Compute Default Service Account
data "google_compute_default_service_account" "default_service_account" {}
