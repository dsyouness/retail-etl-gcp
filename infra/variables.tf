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
