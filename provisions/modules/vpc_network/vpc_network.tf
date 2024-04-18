# VPC Networking
resource "google_compute_network" "vpc_networking" {
  name = var.vpc_name
  description = var.vpc_description
  project = var.vpc_project

	mtu = var.vpc_mtu
  auto_create_subnetworks = var.vpc_autocreate_subnet
  delete_default_routes_on_create = var.delete_default_routes
  network_firewall_policy_enforcement_order = var.firewall_enforcement_order
	routing_mode = var.vpc_routing_mode
}
