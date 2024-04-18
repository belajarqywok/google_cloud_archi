# VPC Network Name
variable "vpc_name" {
  type = string
  default = "gcp-vpc-network"
  description = "VPC Network Name"
}

# VPC Network Description
variable "vpc_description" {
  type = string
  default = "Virtual Private Cloud"
  description = "VPC Network Description"
}

# VPC Network Project
variable "vpc_project" {
	type = string
	sensitive = false
	description = "VPC Network Project"
}

# VPC Network Auto Create Subnet
variable "vpc_autocreate_subnet" {
	type = bool
	default = false
	description = "VPC Network Auto Create Subnet"
}

# VPC Network Delete Default Routes On Create
variable "delete_default_routes" {
	type = bool
	default = false
	description = "VPC Network Delete Default Routes On Create"
}

# VPC Network MTU (Maximum Tranmission Unit)
variable "vpc_mtu" {
	type = number
	default = 1460
	description = "VPC Network MTU (Maximum Tranmission Unit)"
}

# VPC Network Firewall Policy Enforcement Order
variable "firewall_enforcement_order" {
	type = string
	default = "AFTER_CLASSIC_FIREWALL"
	description = "VPC Network Firewall Policy Enforcement Order"
}

# VPC Network Routing Mode
variable "vpc_routing_mode" {
	type = string
	default = "REGIONAL"
	description = "VPC Network Routing Mode"
}
