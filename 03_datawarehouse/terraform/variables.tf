variable "credentials" {
  description = "credentials for project"
  default     = "/Users/gchoong/Projects/dezoomcourse2025/03_datawarehouse/gcs_cred.json"
}
variable "gcs_bucket_name" {
  description = "bucket name"
  default     = "zoomcamp-03-450318-tf-bucket"
}
variable "bq_dataset_name" {
  description = "my big query dataset name"
  default     = "nytaxi_yellow"

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
  default     = "zoomcamp-03-450318"
}
variable "region" {
  description = "project region"
  default     = "us-central1"
}