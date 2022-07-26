locals {
  media_cdn_service_name = format("%s-%s", var.media_cdn_service_name, "tf")
}

resource "google_project_service" "compute_api" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "networking_api" {
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

resource "google_network_services_edge_cache_service" "media_cdn_service" {
  provider              = google-beta
  project               = var.project_id
  name                  = local.media_cdn_service_name
  disable_http2         = var.disable_http2
  disable_quic          = var.disable_quic
  require_tls           = var.require_tls
  edge_ssl_certificates = var.edge_ssl_certificates
  edge_security_policy  = var.edge_security_policy
  dynamic "log_config" {
    for_each = var.log_config == null ? null : [var.log_config]
    content {
      enable      = var.log_config["enable"]
      sample_rate = var.log_config["sample_rate"]
    }
  }

  routing {
    dynamic "host_rule" {
      for_each = var.host_rule
      content {
        hosts        = host_rule.value.hosts
        path_matcher = host_rule.value.path_matcher
      }
    }
    dynamic "path_matcher" {
      for_each = var.path_matcher
      content {
        name = path_matcher.value.name

        dynamic "route_rule" {
          for_each = path_matcher.value.route_rule
          content {
            priority = route_rule.value.priority
            origin   = route_rule.value.origin
            dynamic "match_rule" {
              for_each = route_rule.value.match_rule
              content {
                ignore_case         = match_rule.value.ignore_case
                prefix_match        = match_rule.value.prefix_match
                full_path_match     = match_rule.value.full_path_match
                path_template_match = match_rule.value.path_template_match
                dynamic "header_match" {
                  for_each = match_rule.value.header_match != null ? match_rule.value.header_match : []
                  content {
                    header_name   = header_match.value.header_name
                    present_match = header_match.value.present_match
                    exact_match   = header_match.value.exact_match
                    prefix_match  = header_match.value.prefix_match
                    suffix_match  = header_match.value.suffix_match
                    invert_match  = header_match.value.invert_match
                  }
                }
                dynamic "query_parameter_match" {
                  for_each = match_rule.value.query_parameter_match != null ? match_rule.value.query_parameter_match : []
                  content {
                    name          = query_parameter_match.value.name
                    present_match = query_parameter_match.value.present_match
                    exact_match   = query_parameter_match.value.exact_match
                  }
                }
              }
            }
            dynamic "route_action" {
              for_each = route_rule.value.route_action != null ? route_rule.value.route_action : []
              content {
                dynamic "cdn_policy" {
                  for_each = route_action.value.cdn_policy != null ? route_action.value.cdn_policy : []
                  content {
                    cache_mode              = cdn_policy.value.cache_mode
                    client_ttl              = cdn_policy.value.client_ttl
                    default_ttl             = cdn_policy.value.default_ttl
                    max_ttl                 = cdn_policy.value.max_ttl
                    negative_caching        = cdn_policy.value.negative_caching
                    negative_caching_policy = cdn_policy.value.negative_caching_policy
                    signed_request_mode     = cdn_policy.value.signed_request_mode
                    signed_request_keyset   = cdn_policy.value.signed_request_keyset
                  }
                }
                dynamic "url_rewrite" {
                  for_each = route_action.value.url_rewrite != null ? route_action.value.url_rewrite : []
                  content {
                    path_prefix_rewrite   = url_rewrite.value.path_prefix_rewrite
                    host_rewrite          = url_rewrite.value.host_rewrite
                    path_template_rewrite = url_rewrite.value.path_template_rewrite
                  }
                }
                dynamic "cors_policy" {
                  for_each = route_action.value.cors_policy != null ? route_action.value.cors_policy : []
                  content {
                    max_age           = cors_policy.value.max_age
                    allow_credentials = cors_policy.value.allow_credentials
                    allow_origins     = cors_policy.value.allow_origins
                    allow_methods     = cors_policy.value.allow_methods
                    allow_headers     = cors_policy.value.allow_headers
                    expose_headers    = cors_policy.value.expose_headers
                    disabled          = cors_policy.value.disabled
                  }
                }
              }
            }
            dynamic "url_redirect" {
              for_each = route_rule.value.url_redirect != null ? route_rule.value.url_redirect : []
              content {
                host_redirect          = url_redirect.value.host_redirect
                path_redirect          = url_redirect.value.path_redirect
                prefix_redirect        = url_redirect.value.prefix_redirect
                redirect_response_code = url_redirect.value.redirect_response_code
                https_redirect         = url_redirect.value.https_redirect
                strip_query            = url_redirect.value.strip_query
              }
            }
          }
        }
      }
    }
  }
}
