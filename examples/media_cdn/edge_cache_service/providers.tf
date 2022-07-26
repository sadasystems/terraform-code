provider "google" {
  version = "4.24.0" # see https://github.com/terraform-providers/terraform-provider-google/releases
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  version = "4.24.0" # see https://github.com/terraform-providers/terraform-provider-google-beta/releases
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
