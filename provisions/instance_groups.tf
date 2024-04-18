/*
 *  Instance Group
 *  Loc: Asia-Southeast1 (Singapore)
*/
module "instance_group_sg" {
  source = "./modules/instance_group"

  instance_group_name        = "instance-group-sg"
  instance_group_description = <<-EOF
    Instance Group Asia-Southeast1 (Singapore)
  EOF

  instance_group_region = "asia-southeast1"

  instance_group_base_name = "${
    module.instance_template_sg.instance_template_output_name
  }"

  instance_group_template = "${
    module.instance_template_sg.instance_template_output_self_link_unique
  }"

  instance_group_zone = "asia-southeast1-a"

  instance_group_autoscaler = {
    min_replicas    = 1
    max_replicas    = 5
    cooldown_period = 60

    cpu_utilization = {
      target = 0.85
      predictive_method = "NONE"
    }
  }

  instance_group_health_checker = {
    timeout_sec          = 5
    check_interval_sec   = 10
    healthy_threshold    = 3
    unhealthy_threshold  = 10

    initial_delay_sec    = 300

    http_check = {
      port = 80
      request_path = "/"
      proxy_header = "NONE"
    }
  }
}



/*
 *  Instance Group
 *  Loc: Europe-West3 (Frankfurt, Germany)
*/
module "instance_group_ge" {
  source = "./modules/instance_group"

  instance_group_name        = "instance-group-ge"
  instance_group_description = <<-EOF
    Instance Group Europe-West3 (Frankfurt, Germany)
  EOF

  instance_group_region = "europe-west3"

  instance_group_base_name = "${
    module.instance_template_ge.instance_template_output_name
  }"

  instance_group_template = "${
    module.instance_template_ge.instance_template_output_self_link_unique
  }"

  instance_group_zone = "europe-west3-a"

  instance_group_autoscaler = {
    min_replicas    = 1
    max_replicas    = 5
    cooldown_period = 60

    cpu_utilization = {
      target = 0.85
      predictive_method = "NONE"
    }
  }

  instance_group_health_checker = {
    timeout_sec          = 5
    check_interval_sec   = 10
    healthy_threshold    = 3
    unhealthy_threshold  = 10

    initial_delay_sec    = 300

    http_check = {
      port = 80
      request_path = "/"
      proxy_header = "NONE"
    }
  }
}

