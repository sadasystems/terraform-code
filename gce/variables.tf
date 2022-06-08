variable "project_id" {
  default = "rohan-orbit"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  type        = string
  default     = "a"
  description = "The zone that the machine should be created in."
}

variable "subnet_name" {
  type        = string
  default     = "projects/rohan-orbit/regions/us-central1/subnetworks/thanos-in-usa"
  description = "GCP VPC Subnetwork self link in whic GCE VM being created."
}
