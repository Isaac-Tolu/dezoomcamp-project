terraform {
    required_version = ">1.0"
    backend "local" {}
  required_providers {
      google = {
          source = "hashicorp/google"
      }
  }
}

provider "google" {
  project = var.project
  region = var.region 
}

resource "google_storage_bucket" "data-lake-bucket" {
  name          = "${local.gcs_bucket_name}_${var.project}"
  location      = var.region

  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  force_destroy = true
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "${local.bq_dataset_name}"
  location                    = var.region

  delete_contents_on_destroy = true
}