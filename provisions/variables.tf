# GCP Region
variable "gcp_region" {
  type        = string
  default     = "asia-southeast2"
  description = "GCP Region"
}

# GCP Zone
variable "gcp_zone" {
  type        = string
  default     = "asia-southeast2-a"
  description = "GCP Zone"
}

# GCP Project
variable "gcp_project" {
  type        = string
  default     = "submission-alfariqyraihan"
  description = "GCP Project"
}

# GCP Owner
variable "gcp_owner" {
  type        = string
  default     = "c211bsy3776"
  description = "GCP Owner"
}

# GCP Instance Startup Script
variable "gcp_instance_startup_script" {
  type        = string
  default     = "../services/static_service/startup.sh"
  description = "GCP Instance Startup Script"
}