terraform {
  required_version = ">= 0.13.1" # see https://releases.hashicorp.com/terraform/
}

locals {
  vpc_connector_name = format("%s-%s", var.connector_name, "tf")
  region             = data.google_client_config.google_client.region
}

resource "google_project_service" "networking_api" {
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "serverless_vpc_api" {
  service            = "vpcaccess.googleapis.com"
  disable_on_destroy = false
}

resource "google_vpc_access_connector" "connector" {
  provider       = google-beta
  project        = var.gcp_project_id
  name           = local.vpc_connector_name
  region         = local.region
  network        = var.vpc_name
  ip_cidr_range  = var.ip_cidr_range
  machine_type   = var.machine_type
  max_throughput = var.max_throughput
  min_throughput = var.min_throughput
  depends_on     = [google_project_service.networking_api, google_project_service.serverless_vpc_api]
  timeouts {
    create = var.connector_timeout
    delete = var.connector_timeout
  }
}

data "google_client_config" "google_client" {}
