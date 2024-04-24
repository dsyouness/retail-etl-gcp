# terraform to create bucket in gcs
resource "google_storage_bucket" "bucket" {
  name          = "retail-etl-dsy"
  location      = "EU"
  force_destroy = true
}
# terraform to create dataset in bigquery
resource "google_bigquery_dataset" "dataset" {
  dataset_id    = "retail_dsy"
  friendly_name = "Retail Dataset"
  description   = "Retail Dataset"
  location      = "EU"
}
resource "google_workflows_workflow" "workflow" {
  name            = "retail-dsy-workflow"
  description     = "Retail Dataset Workflow"
  source_contents = local.workflow_yaml
  region          = "europe-west1"
}
# terraform to create table in bigquery
resource "google_bigquery_table" "raw_country" {
  dataset_id = "retail_dsy"
  table_id   = "raw_country"
  schema     = <<EOF
  [
    {
      "name": "id",
      "type": "STRING"
    },
    {
      "name": "iso",
      "type": "STRING"
    },
    {
      "name": "name",
      "type": "STRING"
    },
    {
      "name": "nicename",
      "type": "STRING"
    },
    {
      "name": "iso3",
      "type": "STRING"
    },
    {
      "name": "numcode",
      "type": "STRING"
    },
    {
      "name": "phonecode",
      "type": "STRING"
    }]
  EOF
}
# terraform to create table raw_invoice  InvoiceNo,StockCode,Description,Quantity,InvoiceDate,UnitPrice,CustomerID,Country
resource "google_bigquery_table" "raw_invoice" {
  dataset_id = "retail_dsy"
  table_id   = "raw_invoice"
  schema     = <<EOF
  [
    {
      "name": "InvoiceNo",
      "type": "STRING"
    },
    {
      "name": "StockCode",
      "type": "STRING"
    },
    {
      "name": "Description",
      "type": "STRING"
    },
    {
      "name": "Quantity",
      "type": "STRING"
    },
    {
      "name": "InvoiceDate",
      "type": "STRING"
    },
    {
      "name": "UnitPrice",
      "type": "STRING"
    },
    {
      "name": "CustomerID",
      "type": "STRING"
    },
    {
      "name": "Country",
      "type": "STRING"
    }]
  EOF
}
# terraform to enable Identity and Access Management (IAM) API
resource "google_project_service" "service" {
  service = "iam.googleapis.com"
}

# terraform to create service account
resource "google_service_account" "service_account" {
  account_id   = "retail-etl-sa"
  display_name = "Retail ETL SA"
}

# terraform to grant roles gcs reader to service account
resource "google_project_iam_member" "storage_object_viewer" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

# terraform to grant roles workflow invoker to service account
resource "google_project_iam_member" "workflow_invoker" {
  project = var.project_id
  role    = "roles/workflows.invoker"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

# terraform to grant roles eventarc admin to service account
resource "google_project_iam_member" "eventarc_admin" {
  project = var.project_id
  role    = "roles/eventarc.admin"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}


resource "google_eventarc_trigger" "trigger" {
  name            = "retail-dsy-trigger"
  location        = "eu"
  service_account = google_service_account.service_account.email
  matching_criteria {
    attribute = "type"
    value     = "google.cloud.storage.object.v1.finalized"
  }
  matching_criteria {
    attribute = "bucket"
    value     = google_storage_bucket.bucket.name
  }

  destination {
    workflow = google_workflows_workflow.workflow.id
  }
}