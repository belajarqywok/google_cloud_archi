# Instance Template Public IP (asia-southeast1)
output "instance_public_ip_sg" {
  value = module.instance_template_sg.instance_template_output_compute_address
  description = "Instance Template Public IP (asia-southeast1)"
}

# Instance Template Public IP (europe-west3)
output "instance_public_ip_ge" {
  value = module.instance_template_ge.instance_template_output_compute_address
  description = "Instance Template Public IP (asia-southeast1)"
}
