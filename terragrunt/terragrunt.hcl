locals {
    project = "sada-mediacdn-lab-01-dev"
    region = "us-east1"
    zone = "us-east1-b"
}

inputs = {
  project = "${local.project}"
  region = "${local.region}"
  media_cdn_origin_name  = "spirits"
  gcs_bucket_name = "sasuke-rohan"
  media_cdn_service_name = "spirits-service"
  priority = "1"
  host_redirect = "rohans.dev"
  redirect_response_code = "SEE_OTHER"
  cache_mode = "FORCE_CACHE_ALL"
}

remote_state {
    backend = "gcs"
    generate = {
        path = "tfstate.tf"
        if_exists = "overwrite_terragrunt"
    }
    config = {
        bucket = "gcs-for-media-cdn-rohan"
        prefix = "${path_relative_to_include()}/terraform.tfstate"
        project = "${local.project}"
        location  = "${local.region}"
    }
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
provider "google" {
    version = "4.24.0"
    project = "${local.project}"
    region  = "${local.region}"
    zone    = "${local.zone}"
    }
EOF
}
