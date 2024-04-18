resource "google_project_iam_member" "iam_member" {
  for_each = var.iam_members

  project = var.iam_member_project
  role    = each.value.role
  member  = each.value.email

  dynamic "condition" {
    for_each = each.value.condition != null ? [each.value.condition] : []
    content {
      title       = condition.value.title
      description = condition.value.description
      expression  = condition.value.expression
    }
  }
}
