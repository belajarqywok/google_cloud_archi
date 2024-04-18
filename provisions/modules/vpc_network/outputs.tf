# VPC Networking Output ID
output "vpc_network_output_id" {
  value = google_compute_network.vpc_networking.id
  description = "VPC Networking Output ID"
}

# VPC Networking Output Name
output "vpc_network_output_name" {
  value = google_compute_network.vpc_networking.name
  description = "VPC Networking Output Name"
}
