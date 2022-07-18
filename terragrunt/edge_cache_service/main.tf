
resource "google_network_services_edge_cache_service" "media_cdn_service" {
  name = var.media_cdn_service_name
  project = var.project
  routing {
    host_rule {
      description = "host rule 1"
      hosts = ["rohans.dev"]
      path_matcher = "rohans"
    }
    host_rule {
      description = "host rule 2"
      hosts = ["rohanss.dev"]
      path_matcher = "rohanss"
    }
    path_matcher {
      name = "rohans"
      route_rule {
        description = "a route rule to match against rohans"
        priority = var.priority
        match_rule {
          prefix_match = "/"
        }
        origin = "${var.media_cdn_origin_name}-tf"
        route_action {
          cdn_policy {
              cache_mode = "CACHE_ALL_STATIC"
              default_ttl = "3600s"
          }
        }
        header_action {
          response_header_to_add {
            header_name = "x-cache-status"
            header_value = "{cdn_cache_status}"
          }
        }
      }
    }
    path_matcher {
      name = "rohanss"
      route_rule {
        description = "a route rule to match against rohans"
        priority = var.priority
        match_rule {
          full_path_match = "/rohanss"
          ignore_case = true
          header_match {
            header_name = "rohanss_header_name"
            exact_match = "rohanss_hn"
          }
        }
        header_action {
          response_header_to_add {
            header_name = "x-cache-status"
            header_value = "{cdn_cache_status}"
          }
        }
        url_redirect {
          host_redirect = var.host_redirect
          redirect_response_code = var.redirect_response_code
          https_redirect = true
        }
        route_action {
          cdn_policy {
            cache_mode = var.cache_mode
            default_ttl = "3600s"
            cache_key_policy {
              excluded_query_parameters = ["rohans"]
            }
          }
      }
    }
  }
}
}