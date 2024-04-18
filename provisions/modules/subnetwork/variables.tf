# VPC Subnetwork Name
variable "subnet_name" {
  type = string
  default = "gcp-vpc-subnetwork"
  description = "VPC Subnetwork Name"
}

# VPC Subnetwork Description
variable "subnet_description" {
  type = string
  default = "Virtual Private Cloud Subnetwork"
  description = "VPC Subnetwork Description"
}

# VPC Subnetwork Network
variable "subnet_network" {
  type = string
  description = "VPC Subnetwork Network"
}

# VPC Subnetwork CIDR Range
variable "subnet_cidr_range" {
  type = string
  default = "10.0.0.0/22"
  description = "VPC Subnetwork CIDR Range"
}

# VPC Subnetwork Region
variable "subnet_region" {
  type = string
  default = "asia-southeast2"
  description = "VPC Subnetwork Region"
}

# VPC Subnetwork Purpose
variable "subnet_purpose" {
  type = string
  default = "PRIVATE_RFC_1918"
  description = "VPC Subnetwork Purpose"
}

# VPC Subnetwork Stack Type
variable "subnet_stack_type" {
  type = string
  default = "IPV4_ONLY"
  description = "VPC Subnetwork Stack Type"
}

# VPC Subnetwork Private Google Access
variable "subnet_private_google_access" {
  type = bool
  default = true
  description = "VPC Subnetwork Private Google Access"
}

# VPC Subnetwork Secondary IP Range
variable "subnet_secondary_ip_range" {
  type = list(
    object({
      range_name = string
      ip_cidr_range = string
    })
  )

	default = [
		{
			range_name = "gcp-vpc-subnetwork-1"
			ip_cidr_range = "10.0.0.0/25"
		}
	]

	description = "VPC Subnetwork Secondary IP Range"
}
