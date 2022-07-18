locals {
  media_cdn_origin_name = format("%s-%s", var.media_cdn_origin_name, "tf")

  media_cdn_origin_address = var.gcs_bucket_name != "" ? format("%s%s", "gs://", var.gcs_bucket_name) : (
    var.ip_address_origin == "" ? (
      var.fqdn_origin != "" ? element(split("//", var.fqdn_origin), 1) : ""
    ) : var.ip_address_origin
  )

  fallback_media_cdn_origin = var.create_fallback_origin == true ? google_network_services_edge_cache_origin.fallback_media_cdn_origin.0.id : null
}

resource "google_project_service" "compute_api" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "networking_api" {
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

resource "google_network_services_edge_cache_origin" "media_cdn_origin" {
  provider         = google-beta
  project          = var.gcp_project_id
  name             = local.media_cdn_origin_name
  origin_address   = local.media_cdn_origin_address
  failover_origin  = local.fallback_media_cdn_origin
  max_attempts     = var.max_attempts
  protocol         = var.protocol
  port             = var.port
  retry_conditions = var.retry_conditions

  dynamic "timeout" {
    for_each = var.timeout == null ? null : [var.timeout]
    content {
      connect_timeout      = var.timeout["connect_timeout"]
      max_attempts_timeout = var.timeout["max_attempts_timeout"]
      response_timeout     = var.timeout["response_timeout"]
      read_timeout         = var.timeout["read_timeout"]
    }
  }

  timeouts {
    create = var.media_cdn_origin_timeout
    update = var.media_cdn_origin_timeout
    delete = var.media_cdn_origin_timeout
  }
}

# Fallback Media CDN Origin
resource "google_network_services_edge_cache_origin" "fallback_media_cdn_origin" {
  count            = var.create_fallback_origin ? 1 : 0
  provider         = google-beta
  project          = var.gcp_project_id
  name             = "fallback-${local.media_cdn_origin_name}"
  origin_address   = local.media_cdn_origin_address
  max_attempts     = var.max_attempts
  protocol         = var.protocol
  port             = var.port
  retry_conditions = var.retry_conditions

  dynamic "timeout" {
    for_each = var.timeout == null ? null : [var.timeout]
    content {
      connect_timeout      = var.timeout["connect_timeout"]
      max_attempts_timeout = var.timeout["max_attempts_timeout"]
      response_timeout     = var.timeout["response_timeout"]
      read_timeout         = var.timeout["read_timeout"]
    }
  }

  timeouts {
    create = var.media_cdn_origin_timeout
    update = var.media_cdn_origin_timeout
    delete = var.media_cdn_origin_timeout
  }
}

data "google_client_config" "google_client" {}
