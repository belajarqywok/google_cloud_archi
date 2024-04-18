# VPC Subnetwork
resource "google_compute_subnetwork" "vpc_subnetwork" {
  name = var.subnet_name
  description = var.subnet_description
  network = var.subnet_network

  ip_cidr_range = var.subnet_cidr_range
  region = var.subnet_region
  purpose = var.subnet_purpose
  stack_type = var.subnet_stack_type
  private_ip_google_access = var.subnet_private_google_access
  secondary_ip_range = var.subnet_secondary_ip_range
}