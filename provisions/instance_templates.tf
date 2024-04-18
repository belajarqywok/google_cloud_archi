/*
 *  Instance Template
 *  Loc: Asia-Southeast1 (Singapore)
*/
module "instance_template_sg" {
  source = "./modules/instance_template"

  instance_template_name = "instance-template-sg"
  instance_template_description = <<-EOF
    Instance Template Asia-Southeast1 (Singapore)
  EOF

  instance_template_region       = "asia-southeast1"
  instance_template_machine_type = "e2-medium"
  instance_template_tags         = [ "compute-node-sg" ]

  # Instance Template Scheduling
  instance_template_scheduling = {
    provisioning_model  = "STANDARD"
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
  }

  # Instance Template Disk
  instance_template_disk = {
    auto_delete = false
    boot        = false

    disk_source = {
      name  = "disk-instance-template-sg"
      size  = 10 # 10Gi
      type  = "pd-ssd"
      zone  = "asia-southeast1-a"
      image = {
        family  = "debian-12"
        project = "debian-cloud"
      }
    }

    policy = {
      name       = "disk-backup-every-day-sg"
      region     = "asia-southeast1"
      start_time = "00:00"
      days_in_cycle = 1
    }
  }

  # Instance Template Network Interface
  instance_template_net_interface = {
    network    = "${module.vpc_network.vpc_network_output_name}"
    subnetwork = "${module.vpc_subnetwork_sg.vpc_subnetwork_output_name}"
    stack_type = "IPV4_ONLY"
  }

  instance_template_compute_address = {
    ip_version   = "IPV4"
    address_type = "EXTERNAL"
    network_tier = "PREMIUM"
  }

  instance_template_metadata = {
    ssh-keys = join("\n", [
      "${var.gcp_owner}:${file("../keys/instance-key-sg.pub")}"
    ])
  }
  
  instance_template_startup_script = file(
    "${var.gcp_instance_startup_script}"
  )
}



/*
 *  Instance Template
 *  Loc: Asia-Southeast2 (Jakarta, Indonesia)
*/
module "instance_template_id" {
  source = "./modules/instance_template"

  instance_template_name = "instance-template-id"
  instance_template_description = <<-EOF
    Instance Template Asia-Southeast2 (Indonesia)
  EOF

  instance_template_region       = "asia-southeast2"
  instance_template_machine_type = "e2-medium"
  instance_template_tags         = [ "compute-node-id" ]

  # Instance Template Scheduling
  instance_template_scheduling = {
    provisioning_model  = "STANDARD"
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
  }

  # Instance Template Disk
  instance_template_disk = {
    auto_delete = false
    boot        = false

    disk_source = {
      name  = "disk-instance-template-id"
      size  = 10 # 10Gi
      type  = "pd-ssd"
      zone  = "asia-southeast2-a"
      image = {
        family  = "debian-12"
        project = "debian-cloud"
      }
    }

    policy = {
      name       = "disk-backup-every-day-id"
      region     = "asia-southeast2"
      start_time = "00:00"
      days_in_cycle = 1
    }
  }

  # Instance Template Network Interface
  instance_template_net_interface = {
    network    = "${module.vpc_network.vpc_network_output_name}"
    subnetwork = "${module.vpc_subnetwork_id.vpc_subnetwork_output_name}"
    stack_type = "IPV4_ONLY"
  }

  instance_template_compute_address = {
    ip_version   = "IPV4"
    address_type = "EXTERNAL"
    network_tier = "PREMIUM"
  }

  instance_template_metadata = {
    ssh-keys = join("\n", [
      "${var.gcp_owner}:${file("../keys/instance-key-id.pub")}"
    ])
  }
  
  instance_template_startup_script = file(
    "${var.gcp_instance_startup_script}"
  )
}



/*
 *  Instance Template
 *  Loc: Europe-West3 (Frankfurt, Germany)
*/
module "instance_template_ge" {
  source = "./modules/instance_template"

  instance_template_name = "instance-template-ge"
  instance_template_description = <<-EOF
    Instance Template Europe-West3 (Frankfurt, Germany)
  EOF

  instance_template_region       = "europe-west3"
  instance_template_machine_type = "e2-medium"
  instance_template_tags         = [ "compute-node-ge" ]

  # Instance Template Scheduling
  instance_template_scheduling = {
    provisioning_model  = "STANDARD"
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
  }

  # Instance Template Disk
  instance_template_disk = {
    auto_delete = false
    boot        = false

    disk_source = {
      name  = "disk-instance-template-ge"
      size  = 10 # 10Gi
      type  = "pd-ssd"
      zone  = "europe-west3-a"
      image = {
        family  = "debian-12"
        project = "debian-cloud"
      }
    }

    policy = {
      name       = "disk-backup-every-day-ge"
      region     = "europe-west3"
      start_time = "00:00"
      days_in_cycle = 1
    }
  }

  # Instance Template Network Interface
  instance_template_net_interface = {
    network    = "${module.vpc_network.vpc_network_output_name}"
    subnetwork = "${module.vpc_subnetwork_ge.vpc_subnetwork_output_name}"
    stack_type = "IPV4_ONLY"
  }

  instance_template_compute_address = {
    ip_version   = "IPV4"
    address_type = "EXTERNAL"
    network_tier = "PREMIUM"
  }

  instance_template_metadata = {
    ssh-keys = join("\n", [
      "${var.gcp_owner}:${file("../keys/instance-key-ge.pub")}"
    ])
  }
  
  instance_template_startup_script = file(
    "${var.gcp_instance_startup_script}"
  )
}



/*
 *  Instance Template
 *  Loc: Europe-West2 (London, England)
*/
module "instance_template_en" {
  source = "./modules/instance_template"

  instance_template_name = "instance-template-en"
  instance_template_description = <<-EOF
    Instance Template Europe-West2 (London, England)
  EOF

  instance_template_region       = "europe-west2"
  instance_template_machine_type = "e2-medium"
  instance_template_tags         = [ "compute-node-en" ]

  # Instance Template Scheduling
  instance_template_scheduling = {
    provisioning_model  = "STANDARD"
    on_host_maintenance = "MIGRATE"
    automatic_restart   = true
  }

  # Instance Template Disk
  instance_template_disk = {
    auto_delete = false
    boot        = false

    disk_source = {
      name  = "disk-instance-template-en"
      size  = 10 # 10Gi
      type  = "pd-ssd"
      zone  = "europe-west3-a"
      image = {
        family  = "debian-12"
        project = "debian-cloud"
      }
    }

    policy = {
      name       = "disk-backup-every-day-en"
      region     = "europe-west2"
      start_time = "00:00"
      days_in_cycle = 1
    }
  }

  # Instance Template Network Interface
  instance_template_net_interface = {
    network    = "${module.vpc_network.vpc_network_output_name}"
    subnetwork = "${module.vpc_subnetwork_en.vpc_subnetwork_output_name}"
    stack_type = "IPV4_ONLY"
  }

  instance_template_compute_address = {
    ip_version   = "IPV4"
    address_type = "EXTERNAL"
    network_tier = "PREMIUM"
  }

  instance_template_metadata = {
    ssh-keys = join("\n", [
      "${var.gcp_owner}:${file("../keys/instance-key-en.pub")}"
    ])
  }
  
  instance_template_startup_script = file(
    "${var.gcp_instance_startup_script}"
  )
}
