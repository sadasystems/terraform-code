# provider "google" {
#   # version = "4.14.0" # see https://github.com/terraform-providers/terraform-provider-google/releases
#   project = var.project_id
#   region  = var.region
#   zone    = var.zone
# }

# provider "google-beta" {
#   version = "4.14.0" # see https://github.com/terraform-providers/terraform-provider-google-beta/releases
#   project = var.project_id
#   region  = var.region
#   zone    = var.zone
# }

# terraform {
#   required_version = ">= 0.13.1" # see https://releases.hashicorp.com/terraform/
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "4.14.0"
#     }
#   }
# }

provider "google" {
  version = "4.14.0" # see https://github.com/terraform-providers/terraform-provider-google/releases
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  version = "3.90.1" # see https://github.com/terraform-providers/terraform-provider-google-beta/releases
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# terraform {
#   required_providers {
#     google = {
#       source = "hashicorp/google"
#       version = "4.24.0"
#     }
#   }
# }

# provider "google" {
#   project = var.project_id
#   region  = var.region
# }
