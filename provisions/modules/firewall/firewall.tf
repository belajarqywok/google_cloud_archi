resource "google_compute_firewall" "vpc_firewall" {
  name        = var.firewall_name
  description = var.firewall_description
  network     = var.firewall_network

	priority           = var.firewall_priority
	direction          = var.firewall_direction
	source_ranges      = var.firewall_source_ranges
	destination_ranges = var.firewall_destination_ranges
	
	# dynamic "allow" {
	# 	for_each = var.firewall_allows
	# 	content {
	# 		protocol = allow.value.protocol
	# 		ports    = allow.value.ports
	# 	}
	# }

	allow {
	  protocol = var.firewall_allow.protocol
	  ports    = var.firewall_allow.ports
	}

	target_tags = var.firewall_tags
}
