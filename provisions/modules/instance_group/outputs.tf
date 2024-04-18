# Instance Group Output Name
output "instance_group_output_name" {
  value = google_compute_instance_group_manager.instance_group_manager.name
  description = "Instance Group Output Name"
}

# Instance Group Output ID
output "instance_group_output_id" {
  value = google_compute_instance_group_manager.instance_group_manager.id
  description = "Instance Group Output ID"
}
