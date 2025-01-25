terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.17.0"
    }
  }
}

provider "google" {
  credentials = "/Users/gchoong/Projects/dezoomcourse2025/tf-demo/keys/my_creds.json"
  project = "intense-dolphin-448915-e9"
  region  = "us-central1"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "intense-dolphin-448915-e9-tf-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}