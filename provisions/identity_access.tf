# IAM Configuration (Local)
locals {
  members = [
    {
      email = "user:alfariqyraihan@gmail.com"
      roles = [ "roles/compute.admin" ]
      condition = null
    },

    {
      email = "group:reviewer_googlecloud@dicoding.com"
      roles = [
        "roles/compute.viewer",
        "roles/compute.networkViewer",

        # loadBalancerViewer (Custom Role)
        "${google_project_iam_custom_role.load_balancer_viewer.id}"
      ]
      condition = {
        title = "expires_after_2024_12_31"
        description = "Expiring at midnight of 2024-12-31"
        expression  = <<-EOT
          request.time < timestamp("2025-01-01T00:00:00Z")
        EOT
      }
    }
  ]
}

# IAM Access
module "iam_access" {
  count              = length(local.members)
	source             = "./modules/iam"
  iam_member_project = var.gcp_project

	iam_members = {
    for member_role in local.members[count.index].roles :
      "${local.members[count.index].email}-${member_role}" => {
        role      = member_role
        email     = local.members[count.index].email
        condition = can(
          local.members[count.index].condition
        ) ? local.members[count.index].condition : null
      }
  }
}
