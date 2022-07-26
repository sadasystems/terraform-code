variable "project_id" {
  default = "sada-mediacdn-lab-01-dev"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  type        = string
  default     = "a"
  description = "The zone that the machine should be created in."
}

# variable "path_template_match" {
#   default = [null, "/*/path", "/*/path/path2"]
#   type = list(string)
# }

variable "header_name" {
  default = ["", "rohan", "sada"]
}

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
