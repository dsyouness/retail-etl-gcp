locals {
  workflow_yaml = file("${path.module}/workflow/workflow.yaml")
  project_id     = var.project_id
}