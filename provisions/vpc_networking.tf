/*
		VPC Networking
*/
module "vpc_network" {
  source          = "./modules/vpc_network"

  vpc_name        = "${var.gcp_project}-vpc-network"
  vpc_project     = var.gcp_project
  vpc_description = <<-EOT
		VPC Networking For Submission
	EOT

	vpc_mtu                    = 1460
	vpc_autocreate_subnet      = false
	delete_default_routes      = false
	firewall_enforcement_order = "AFTER_CLASSIC_FIREWALL"
	vpc_routing_mode           = "REGIONAL"
}


/*
		VPC Subnetwork for Asia-Southeast1
		(loc: Singapore)
*/
module "vpc_subnetwork_sg" {
	source = "./modules/subnetwork"

	subnet_name        = "${var.gcp_project}-vpc-subnetwork-sg"
	subnet_network     = "${module.vpc_network.vpc_network_output_id}"
	subnet_description = <<-EOT
		VPC Subnetwork For Asia-Southeast1 (Singapore) Region
	EOT

	subnet_cidr_range = "10.0.0.0/24"
	subnet_region     = "asia-southeast1"
	subnet_purpose    = "PRIVATE_RFC_1918"
	subnet_stack_type = "IPV4_ONLY"
	subnet_private_google_access = true

	subnet_secondary_ip_range = [
		{
			range_name    = "${var.gcp_project}-vpc-subnetwork-sg-1"
			ip_cidr_range = "11.0.0.0/26"
		}
	]
}


/*
		VPC Subnetwork for Asia-Southeast2
		(loc: Jakarta, Indonesia)
		
		{ reserve }
*/
module "vpc_subnetwork_id" {
	source = "./modules/subnetwork"

	subnet_name        = "${var.gcp_project}-vpc-subnetwork-id"
	subnet_network     = "${module.vpc_network.vpc_network_output_id}"
	subnet_description = <<-EOT
		VPC Subnetwork For Asia-Southeast2 (Jakarta) Region
	EOT

	subnet_cidr_range = "10.0.1.0/24"
	subnet_region     = "asia-southeast2"
	subnet_purpose    = "PRIVATE_RFC_1918"
	subnet_stack_type = "IPV4_ONLY"
	subnet_private_google_access = true

	subnet_secondary_ip_range = [
		{
			range_name    = "${var.gcp_project}-vpc-subnetwork-id-1"
			ip_cidr_range = "11.0.1.0/26"
		}
	]
}


/*
		VPC Subnetwork for Europe-West3
		(loc: Frankfurt, Germany)
*/
module "vpc_subnetwork_ge" {
	source = "./modules/subnetwork"

	subnet_name        = "${var.gcp_project}-vpc-subnetwork-ge"
	subnet_network     = "${module.vpc_network.vpc_network_output_id}"
	subnet_description = <<-EOT
		VPC Subnetwork For Europe-West3 (Frankfurt) Region
	EOT

	subnet_cidr_range = "10.0.2.0/24"
	subnet_region     = "europe-west3"
	subnet_purpose    = "PRIVATE_RFC_1918"
	subnet_stack_type = "IPV4_ONLY"
	subnet_private_google_access = true

	subnet_secondary_ip_range = [
		{
			range_name    = "${var.gcp_project}-vpc-subnetwork-ge-1"
			ip_cidr_range = "11.0.2.0/26"
		}
	]
}


/*
		VPC Subnetwork for Europe-West2
		(loc: London, England)

		{ reserve }
*/
module "vpc_subnetwork_en" {
	source = "./modules/subnetwork"

	subnet_name        = "${var.gcp_project}-vpc-subnetwork-en"
	subnet_network     = "${module.vpc_network.vpc_network_output_id}"
	subnet_description = <<-EOT
		VPC Subnetwork For Europe-West2 (London) Region
	EOT

	subnet_cidr_range = "10.0.3.0/24"
	subnet_region     = "europe-west2"
	subnet_purpose    = "PRIVATE_RFC_1918"
	subnet_stack_type = "IPV4_ONLY"
	subnet_private_google_access = true

	subnet_secondary_ip_range = [
		{
			range_name    = "${var.gcp_project}-vpc-subnetwork-en-1"
			ip_cidr_range = "11.0.3.0/26"
		}
	]
}


/*
		VPC Firewall Allow HTTP, HTTPS, and SSH
		(ports: 80, 443, and 22)
*/
module "vpc_firewall_http_https_ssh" {
	source = "./modules/firewall"

	firewall_name        = "${var.gcp_project}-vpc-fw-http-https-ssh"
	firewall_network     = "${module.vpc_network.vpc_network_output_id}"
	firewall_description = <<-EOT
		VPC Firewall Allow HTTP, HTTPS, and SSH
	EOT

	firewall_priority           = 65534
	firewall_direction          = "INGRESS"
	firewall_source_ranges      = [ "0.0.0.0/0" ]
	firewall_destination_ranges = [
		// asia-southeast1 (Singapore)
    "10.0.0.0/24", "11.0.0.0/26",

    // asia-southeast2 (Jakarta, Indonesia)
    "10.0.1.0/24", "11.0.1.0/26",

		// europe-west3 (Frankfurt, Germany)
		"10.0.2.0/24", "11.0.2.0/26",

		// europe-west2 (London, England)
		"10.0.3.0/24", "11.0.3.0/26",
	]

	firewall_allow = {
		protocol = "tcp"
		ports    = [ "80", "443", "22" ]
	}

	firewall_tags = [
		"compute-node-sg",
		"compute-node-id",
		"compute-node-ge",
		"compute-node-en",
	]
}
