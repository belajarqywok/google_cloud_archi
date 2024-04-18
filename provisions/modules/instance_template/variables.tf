# Instance Template Name 
variable "instance_template_name" {
  type        = string
  default     = "compute-instance-template"
  description = "Compute Instance Template Name"
}

# Instance Template Description
variable "instance_template_description" {
  type        = string
  default     = "Blablablabalbal....."
  description = "Compute Instance Template Description"
}

# Instance Template Region
variable "instance_template_region" {
  type        =  string
  default     = "asia-southeast2"
  description = "Compute Instance Template Region"
}

# Instance Template Machine Type
variable "instance_template_machine_type" {
  type        = string
  default     = "e2-medium"
  description = "Compute Instance Template Machine Type"
}

# Instance Template Tags
variable "instance_template_tags" {
  type        = set(string)
  default     = [ "tag1", "tag2" ]
  description = "Instance Template Tags"
}

# Instance Template Scheduling
variable "instance_template_scheduling" {
  type = object({
    provisioning_model  = string
    on_host_maintenance = string
    automatic_restart   = bool
  })

  default = {
    provisioning_model  = "STANDARD"
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
  }

  description = "Instance Template Scheduling"
}

#  Instance Template Disk
variable "instance_template_disk" {
  type = object({
    auto_delete = bool
    boot        = bool

    disk_source = object({
      name  = string
      size  = number
      type  = string
      zone  = string
      image = object({
        family  = string
        project = string
      })
    })

    policy = object({
      name       = string
      region     = string
      start_time = string
      days_in_cycle = number
    })
  })

  default = {
    auto_delete = false
    boot        = false

    disk_source = {
      name  = "disk"
      size  = 10
      type  = "pd-ssd"
      zone  = "asia-southeast2-a"
      image = {
        family  = "debian-11"
        project = "debian-cloud"
      }
    }

    policy = {
      name       = "every-day-4am"
      region     = "asia-southeast2"
      start_time = "04:00"
      days_in_cycle = 1
    }
  }

  description = "Instance Template Disk"
}

# Instance Template Network Interface
variable "instance_template_net_interface" {
  type = object({
    network    = string
    subnetwork = string
    stack_type = string
  })

  default = {
    network    = "default"
    subnetwork = "asia-southeast2"
    stack_type = "IPV4_ONLY"
  }

  description = "Instance Template Network Interface"
}

# Instance Template Metadata
variable "instance_template_metadata" {
  type = map(string)

  default = {
    ssh-keys = "USER:SSH_PUBLIC_KEY"
  }

  description = "Instance Template Metadata"
}

# Instance Template Startup Script
variable "instance_template_startup_script" {
  type = string

  default = <<-EOT
    #!/bin/bash
    sudo apt update && sudo apt upgrade
    sudo apt install apache2
  EOT

  description = "Instance Template Startup Script"
}

# Instance Template Compute Address
variable "instance_template_compute_address" {
  type = object({
    ip_version   = string
    address_type = string
    network_tier = string
  })

  default = {
    ip_version   = "IPV4"
    address_type = "EXTERNAL"
    network_tier = "PREMIUM"
  }

  description = "Instance Template Compute Address"
}
