variable "project" {
  type     = string
  nullable = false
}

variable "media_cdn_origin_name" {
  type     = string
  nullable = false
}

variable "gcs_bucket_name" {
  type     = string
  nullable = false
}

# variable "region" {
#   default = "us-central1"
# }

# variable "zone" {
#   type        = string
#   default     = "a"
#   description = "The zone that the machine should be created in."
# }

# variable "vpc_name" {
#   description = "GCP VPC Name self link in which GCP Cloud Function being created."
#   default     = "projects/rohan-orbit/global/networks/thanos"
#   type        = string
# }

# variable "subnet_name" {
#   description = "GCP VPC Subnetwork self link in which GCP Cloud Function being created."
#   default     = "projects/rohan-orbit/regions/us-central1/subnetworks/thanos-in-usa"
#   type        = string
# }
