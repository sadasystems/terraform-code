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

variable "prefix_match" {
  default = ["", "/home", "/nohome", "/rohan"]
  type = list(string)
}

variable "full_path_match" {
  default = ["", "/full/path", "path/match", "match/full"]
  type = list(string)
}

# variable "path_template_match" {
#   default = [null, "/*/path", "/*/path/path2"]
#   type = list(string)
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
