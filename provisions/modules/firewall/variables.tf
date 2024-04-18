# VPC Firewall Name
variable "firewall_name" {
  type = string
  default = "gcp-vpc-firewall"
  description = "VPC Firewall Name"
}

# VPC Firewall Description
variable "firewall_description" {
  type = string
  default = "Virtual Private Cloud Firewall"
  description = "VPC Firewall Description"
}

# VPC Firewall Network
variable "firewall_network" {
  type = string
  description = "VPC Firewall Network"
}

# VPC Firewall Priority
variable "firewall_priority" {
  type = string
  default = 65534
  description = "VPC Firewall Priority"
}

# VPC Firewall Direction
variable "firewall_direction" {
  type = string
  description = "VPC Firewall Direction"
}

# VPC Firewall Source Ranges
variable "firewall_source_ranges" {
  type = set(string)
  default = [ "0.0.0.0/24" ]
  description = "VPC Firewall Source Ranges"
}

# VPC Firewall Destination Ranges
variable "firewall_destination_ranges" {
  type = set(string)
  default = [ "0.0.0.0/24" ]
  description = "VPC Firewall Destination Ranges"
}

# VPC Firewall Allow
variable "firewall_allow" {
  type = object({
    protocol = string
    ports = list(string)
  })

  default = {
    protocol = "tcp"
    ports    = [ "80", "443" ]
  }

  description = "VPC Firewall Allow"
}

# VPC Firewall Allows
# variable "firewall_allows" {
#   type = map(
#     object({
# 			protocol = string
# 			ports = list(string)
#     })
#   )

# 	default = {
# 		tcp_allow = {
# 			protocol = "tcp"
# 			ports = [ "22" ]
# 		} 
#   }

# 	description = "VPC Firewall Allows"
# }

# VPC Firewall Tags
variable "firewall_tags" {
	type = set(string)
	default = [ "vm-1", "vm-2" ]
	description = "VPC Firewall Tags"
}
