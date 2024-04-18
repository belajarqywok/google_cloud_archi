# Instance Health Checker
resource "google_compute_health_check" "instance_health_checker" {
  name        = "${var.instance_group_name}-http-health-check"
  description = "${var.instance_group_name} Health Checking"

  timeout_sec         = var.instance_group_health_checker.timeout_sec
  check_interval_sec  = var.instance_group_health_checker.check_interval_sec
  healthy_threshold   = var.instance_group_health_checker.healthy_threshold
  unhealthy_threshold = var.instance_group_health_checker.unhealthy_threshold

  http_health_check {
    port               = var.instance_group_health_checker.http_check.port
    request_path       = var.instance_group_health_checker.http_check.request_path
    proxy_header       = var.instance_group_health_checker.http_check.proxy_header
  }
}

# Instance Group Manager
resource "google_compute_instance_group_manager" "instance_group_manager" {
  name        = var.instance_group_name
  description = var.instance_group_description

  zone = var.instance_group_zone

  base_instance_name   = var.instance_group_name
  version {
    instance_template  = var.instance_group_template
  }

  # distribution_policy_zones        = [ var.instance_group_zone ]
  # distribution_policy_target_shape = var.instance_group_target_shape

  auto_healing_policies {
    health_check      = google_compute_health_check.instance_health_checker.id
    initial_delay_sec = var.instance_group_health_checker.initial_delay_sec
  }

  # instance_lifecycle_policy {
  #   force_update_on_repair    = var.instance_group_force_update
  #   default_action_on_failure = var.instance_group_action_on_failure
  # }
}

# Instance Autoscaler
resource "google_compute_autoscaler" "instance_autoscaler" {
  name   = google_compute_instance_group_manager.instance_group_manager.name

  target = google_compute_instance_group_manager.instance_group_manager.id 
  zone   = var.instance_group_zone

  autoscaling_policy {
    min_replicas    = var.instance_group_autoscaler.min_replicas
    max_replicas    = var.instance_group_autoscaler.max_replicas
    cooldown_period = var.instance_group_autoscaler.cooldown_period

    cpu_utilization {
      target            = var.instance_group_autoscaler.cpu_utilization.target
      predictive_method = var.instance_group_autoscaler.cpu_utilization.predictive_method
    }
  }
}
