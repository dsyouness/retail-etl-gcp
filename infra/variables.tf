variable "project_id" {
  type = string
  default = "retail-etl"
  description = "The project id"
}

variable "region" {
  type        = string
  default     = "europe-west1"
  description = "Region for regional GCP resources"
}

variable "dbt_job_name" {
  type        = string
  default     = "retail-etl-dbt-job"
  description = "Cloud Run job name that executes dbt"
}

variable "dbt_image" {
  type        = string
  default     = "ghcr.io/dbt-labs/dbt-bigquery:1.8.2"
  description = "Container image used by Cloud Run Job to run dbt with BigQuery"
}


variable "github_owner" {
  type        = string
  description = "GitHub owner/org that hosts the repository"
}

variable "github_repo_name" {
  type        = string
  description = "GitHub repository name connected to Cloud Build"
}

variable "cloudbuild_trigger_name" {
  type        = string
  default     = "retail-etl-all-branches"
  description = "Cloud Build trigger name for Terraform pipeline"
}

variable "cloudbuild_trigger_branch_regex" {
  type        = string
  default     = ".*"
  description = "Regex used by Cloud Build trigger to match branches"
}


variable "tf_state_bucket" {
  type        = string
  default     = "retail-etl-tfstate"
  description = "GCS bucket used by Terraform remote state"
}

variable "tf_state_prefix" {
  type        = string
  default     = "terraform/infra"
  description = "Prefix/path used in GCS backend for Terraform state"
}
