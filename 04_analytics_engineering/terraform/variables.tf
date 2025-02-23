variable "credentials" {
  description = "credentials for project"
  default     = "/Users/gchoong/Projects/dezoomcourse2025/04_analytics_engineering/terraform/gcs_creds.json"
}
variable "gcs_bucket_name" {
  description = "bucket name"
  default     = "analytics-451817-bucket"
}
variable "gcs_storage_class" {
  description = "bucket storage class"
  default     = "STANDARD"
}
variable "location" {
  description = "project location"
  default     = "US"
}
variable "project" {
  description = "project location"
  default     = "analytics-451817"
}
variable "region" {
  description = "project region"
  default     = "us-central1"
}