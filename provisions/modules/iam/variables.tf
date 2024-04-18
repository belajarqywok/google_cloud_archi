# IAM Custom Title
variable "iam_custom_title" {
  type = string
  default = "My Custom Role"
  description = "IAM Custom Title"
}

# IAM Custom Description
variable "iam_custom_description" {
  type    = string
  default = <<-EOT
    Identity, And Access
    Management Custom
  EOT

  description = "IAM Custom Description"
}

# IAM Custom Role ID
variable "iam_custom_role_id" {
  type        = string
  default     = "myCustomRole"
  description = "IAM Custom Role ID"
}

# IAM Custom Permissions
variable "iam_custom_permissions" {
  type    = set(string)
  default = [ 
    "iam.roles.list",
    "iam.roles.create",
    "iam.roles.delete"
  ]

	description = "IAM Custom Permissions"
}

# IAM Member Project
variable "iam_member_project" {
	type        = string
	default     = "your-project-id"
	description = "IAM Member Project"
}

# IAM Member Email
variable "iam_member_email" {
	type        = string
	default     = "jane@example.com"
	description = "IAM Member Email"
}

# IAM Member Condition
variable "iam_member_condition" {
	type = object({
		title       = string
		description = string
		expression  = string
	})

	default = {
		title = "expires_after_2024_12_31"
		description = "Expiring at midnight of 2023-12-31"
    expression  = <<-EOT
      request.time < timestamp("2025-01-01T00:00:00Z")
    EOT
	}

	description = "IAM Member Condition"
}

# IAM Members
variable "iam_members" {
  type = map(object({
    role      = string
    email     = string
    condition = optional(object({
      title       = string
      description = string
      expression  = string
    }))
  }))

  default = {
    example_member = {
      role  = "roles/myCustomRole"
      email = "alfariqyraihan@gmail.com"
      condition = {
        title       = "expires_after_2024_12_31"
        description = "Expiring at midnight of 2023-12-31"
        expression  = "request.time < timestamp(\"2025-01-01T00:00:00Z\")"
      }
    }
  }

  description = "IAM Members"
}

