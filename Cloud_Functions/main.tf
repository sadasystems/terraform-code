terraform {
  required_version = ">= 0.13.1" # see https://releases.hashicorp.com/terraform/
}

locals {
  vpc_connector_name = format("%s-%s", var.connector_name, "tf")
  vpc_connector = var.create_vpc_connector == true ? google_vpc_access_connector.connector.0.id : (
    var.existing_vpc_conn_name == "" ? null : var.existing_vpc_conn_name
  )

  cloud_func_name = format("%s-%s", var.cloud_func_name, "tf")
}

resource "google_project_service" "networking_api" {
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
  # project = var.gcp_project_id
}

resource "google_project_service" "serverless_vpc_api" {
  service            = "vpcaccess.googleapis.com"
  disable_on_destroy = false
  # project = var.gcp_project_id
}

resource "google_project_service" "cloud_functions" {
  service            = "cloudfunctions.googleapis.com"
  disable_on_destroy = false
  # project = var.gcp_project_id
}

resource "google_project_service" "artifact_registry_api" {
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
  # project = var.gcp_project_id
}

resource "google_project_service" "cloud_run_api" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
  # project = var.gcp_project_id
}

resource "google_project_service" "cloud_build_api" {
  service            = "cloudbuild.googleapis.com"
  disable_on_destroy = false
  # project = var.gcp_project_id
}

resource "google_project_service" "cloud_logging_api" {
  service            = "logging.googleapis.com"
  disable_on_destroy = false
  # project = var.gcp_project_id
}

resource "google_project_service" "pubsub_logging_api" {
  service            = "pubsub.googleapis.com"
  disable_on_destroy = false
  # project = var.gcp_project_id
}

resource "google_vpc_access_connector" "connector" {
  count          = var.create_vpc_connector ? 1 : 0
  name           = local.vpc_connector_name
  region         = var.region
  ip_cidr_range  = var.cidr_range
  max_throughput = 300
  network        = var.vpc_name
  # depends_on     = [google_project_service.networking_api, google_project_service.serverless_vpc_api]
  timeouts {
    create = var.connector_timeout
    delete = var.connector_timeout
  }
}

resource "google_cloudfunctions_function" "cloud_func" {
  name        = local.cloud_func_name
  runtime     = var.cloud_func_runtime
  region      = var.region
  description = var.cloud_func_description

  available_memory_mb = var.available_memory_mb
  timeout             = var.cloud_func_timeout
  entry_point         = var.cloud_func_entry_point

  event_trigger {
    event_type = var.event_trigger["event_type"]
    resource   = var.event_trigger["resource"]
    failure_policy {
      retry = var.cloud_func_failure_retry
    }
  }

  trigger_http     = var.cloud_func_trigger_http
  ingress_settings = var.cloud_func_ingress_settings

  labels                      = var.cloud_func_labels
  environment_variables       = var.env_vars
  build_environment_variables = var.build_env_vars

  service_account_email = var.sa_email

  vpc_connector                 = local.vpc_connector
  vpc_connector_egress_settings = var.vpc_connector_egress_settings

  source_archive_bucket = var.cloud_func_source_code_bucket_name
  source_archive_object = var.cloud_func_code_filename

  # source_repository {
  #   url = var.source_repo_url
  # }

  max_instances = var.max_instances
  min_instances = var.min_instances

  secret_environment_variables {
    key        = var.secret_env_vars["key"]
    secret     = var.secret_env_vars["secret"]
    version    = var.secret_env_vars["version"]
    project_id = var.gcp_project_id
  }

  secret_volumes {
    mount_path = var.sec_vols["mount_path"]
    secret     = var.sec_vols["secret"]
    versions {
      path    = var.sec_vols_versions["path"]
      version = var.sec_vols_versions["version"]
    }
  }

  timeouts {
    create = var.cloud_func_resource_timeout
    delete = var.cloud_func_resource_timeout
  }
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  for_each       = var.public_func ? toset(var.cloud_func_invoker) : []
  project        = google_cloudfunctions_function.cloud_func.project
  region         = google_cloudfunctions_function.cloud_func.region
  cloud_function = google_cloudfunctions_function.cloud_func.name
  role           = "roles/cloudfunctions.invoker"
  member         = each.value
}

data "google_client_config" "google_client" {}
