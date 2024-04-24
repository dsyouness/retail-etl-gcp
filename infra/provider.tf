terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.13.0"
    }
  }
}
provider "google" {
  project     = "retail-etl"
  credentials = file("retail-etl-5d649fa6a1f8.json")
}