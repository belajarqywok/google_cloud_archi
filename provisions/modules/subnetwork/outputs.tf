# VPC Subnetwork Output Name
output "vpc_subnetwork_output_name" {
  value = google_compute_subnetwork.vpc_subnetwork.name
  description = "VPC Subnetwork Output Name"
}

# VPC Subnetwork Output ID
output "vpc_subnetwork_output_id" {
  value = google_compute_subnetwork.vpc_subnetwork.id
  description = "VPC Subnetwork Output Name"
}