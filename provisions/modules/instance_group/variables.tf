# Instance Group Name
variable "instance_group_name" {
  type        = string
  default     = "instance-group-name"
  description = "Instance Group Name"
}

# Instance Group Description
variable "instance_group_description" {
  type    = string
  default = <<-EOT
    blablablabalbalbalbalabla
    blablablabalbalbalbalabla
    blablablabalbalbalbalabla
  EOT

  description = "Instance Group Description"
}

# Instance Group Region
variable "instance_group_region" {
  type        = string
  default     = "asia-southeast2"
  description = "Instance Group Region"
}

# Instance Group Base Name
variable "instance_group_base_name" {
  type        = string
  default     = "catalog-service"
  description = "Instance Group Base Name"
}

# Instance Group Template
variable "instance_group_template" {
  type    = string
  default = <<-EOT
    self_link_unique (instance template)
    example: projects/{{project}}/global/instanceTemplates/{{name}}?uniqueId={{uniqueId}}
  EOT
  
  description = "Instance Group Template"
}

# Instance Group Zone
variable "instance_group_zone" {
  type        = string
  default     = "asia-southeast2-a"
  description = "Instance Group Zones"
}

# Instance Target Shape
# variable "instance_group_target_shape" {
#   type        = string
#   default     = "EVEN"
#   description = "Instance Target Shape"
# }

# Instance Group Scaling Size
# variable "instance_group_scaling_size" {
#   type        = number
#   default     = 0
#   description = "Instance Group Scaling Size"
# }

# Instance Group Autoscaler
variable "instance_group_autoscaler" {
  type = object({
    min_replicas    = number
    max_replicas    = number
    cooldown_period = number
    cpu_utilization = object({
      target            = number
      predictive_method = string
    })
  })

  default = {
    min_replicas    = 1
    max_replicas    = 5
    cooldown_period = 60

    cpu_utilization = {
      target = 0.85
      predictive_method = "NONE"
    }
  }

  description = "Instance Group Autoscaler"
}

# Instance Group Health Checker
variable "instance_group_health_checker" {
  type = object({
    timeout_sec         = number
    check_interval_sec  = number
    healthy_threshold   = number
    unhealthy_threshold = number

    initial_delay_sec   = number

    http_check = object({
      port         = number
      request_path = string
      proxy_header = string
    })
  })

  default = {
    timeout_sec          = 10
    check_interval_sec   = 5
    healthy_threshold    = 3
    unhealthy_threshold  = 15

    initial_delay_sec    = 300

    http_check = {
      port = 80
      request_path = "/"
      proxy_header = "NONE"
    }
  }

  description = "Instance Group Health Checker"
}

# Instance Group Force Update
# variable "instance_group_force_update" {
#   type        = string
#   default     = "NO"
#   description = "Instance Group Force Update"
# }

# Instance Group Action On Failure
# variable "instance_group_action_on_failure" {
#   type        = string
#   default     = "REPAIR"
#   description = "Instance Group Action On Failure"
# }
