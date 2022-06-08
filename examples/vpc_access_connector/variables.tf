variable "project_id" {
  default = "rohan-orbit"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  description = "The zone that the machine should be created in."
  default     = "a"
  type        = string
}

variable "vpc_name" {
  description = "GCP VPC Name in which VPC Access Connector will reside."
  default     = "thanos"
  type        = string
}
