# Instance Template Output Name
output "instance_template_output_name" {
  value = google_compute_instance_template.instance_template.name
  description = "Instance Template Output Name"
}

# Instance Template Output Self Link Unique
output "instance_template_output_self_link_unique" {
  value = google_compute_instance_template.instance_template.self_link_unique
  description = "Instance Template Output Name"
}

# Instance Template Output Compute Address
output "instance_template_output_compute_address" {
  value = google_compute_address.compute_address.address
  description = "Instance Template Output Compute Address"
}