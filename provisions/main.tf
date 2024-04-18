terraform {
  required_version = ">= 1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0"
    }
  }

  backend "gcs" {
    bucket  = "submission-alfariqyraihan-storage"
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}
