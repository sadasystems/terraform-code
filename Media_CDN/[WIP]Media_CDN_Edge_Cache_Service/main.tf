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
  for_each = { for obj in var.routing : obj.routing_host_rule_description => obj }
  provider = google-beta
  project  = var.gcp_project_id
  name     = local.media_cdn_service_name

  routing {
    host_rule { # multiple 
      description  = each.value.routing_host_rule_description
      hosts        = each.value.routing_host_rule_hosts
      path_matcher = each.value.routing_host_rule_path_matcher
    }
    path_matcher { # multiple
      name   = each.value.routing_host_rule_path_matcher
      origin = each.value.route_rule_origin
      url_redirect {
          host_redirect          = each.value.route_rule_url_redirect_host_redirect
          path_redirect          = each.value.route_rule_url_redirect_path_redirect
          prefix_redirect        = each.value.route_rule_url_redirect_prefix_redirect
          redirect_response_code = each.value.route_rule_url_redirect_redirect_response_code
          https_redirect         = each.value.route_rule_url_redirect_https_redirect
          strip_query            = each.value.route_rule_url_redirect_strip_query
      }
      route_rule { # multiple
        priority    = each.value.path_matcher_route_rule_priority
        description = each.value.path_matcher_route_rule_description
        match_rule { # multiple
          ignore_case = each.value.path_matcher_route_rule_match_rule_ignore_case
          header_match { # multiple
            header_name   = each.value.path_matcher_route_rule_match_rule_header_match_header_name
            present_match = each.value.path_matcher_route_rule_match_rule_header_match_present_match
            exact_match   = each.value.path_matcher_route_rule_match_rule_header_match_exact_match
            prefix_match  = each.value.path_matcher_route_rule_match_rule_header_match_prefix_match
            suffix_match  = each.value.path_matcher_route_rule_match_rule_header_match_suffix_match
            invert_match  = each.value.path_matcher_route_rule_match_rule_header_match_invert_match
          }
          query_parameter_match { # multiple
            name          = each.value.path_matcher_route_rule_match_rule_query_parameter_match_name
            present_match = each.value.path_matcher_route_rule_match_rule_query_parameter_match_present_match
            exact_match   = each.value.path_matcher_route_rule_match_rule_query_parameter_match_exact_match
          }
          prefix_match    = each.value.path_matcher_route_rule_match_rule_prefix_match
          full_path_match = each.value.path_matcher_route_rule_match_rule_full_path_match
        }
        header_action { # mutliple
          request_header_to_add {
            header_name  = each.value.path_matcher_route_rule_match_header_action_request_header_to_add_header_name
            header_value = each.value.path_matcher_route_rule_match_header_action_request_header_to_add_header_value
            replace      = each.value.path_matcher_route_rule_match_header_action_request_header_to_add_replace
          }
          response_header_to_add {
            header_name  = each.value.path_matcher_route_rule_match_header_action_response_header_to_add_header_name
            header_value = each.value.path_matcher_route_rule_match_header_action_response_header_to_add_header_value
            replace      = each.value.path_matcher_route_rule_match_header_action_response_header_to_add_replace
          }
          request_header_to_remove {
            header_name  = each.value.path_matcher_route_rule_match_header_action_request_header_to_remove_header_name
            header_value = each.value.path_matcher_route_rule_match_header_action_request_header_to_remove_header_value
            replace      = each.value.path_matcher_route_rule_match_header_action_request_header_to_remove_replace
          }
          response_header_to_remove {
            header_name  = each.value.path_matcher_route_rule_match_header_action_response_header_to_remove_header_name
            header_value = each.value.path_matcher_route_rule_match_header_action_response_header_to_remove_header_value
            replace      = each.value.path_matcher_route_rule_match_header_action_response_header_to_remove_replace
          }
        }
        route_action {
          cdn_policy {
            cache_mode  = each.value.path_matcher_route_rule_cdn_policy_cache_mode
            client_ttl  = each.value.path_matcher_route_rule_cdn_policy_client_ttl
            default_ttl = each.value.path_matcher_route_rule_cdn_policy_default_ttl
            max_ttl     = each.value.path_matcher_route_rule_cdn_policy_max_ttl
            cache_key_policy {
              include_protocol          = each.value.path_matcher_route_rule_cache_key_policy_include_protocol
              exclude_query_string      = each.value.path_matcher_route_rule_cache_key_policy_exclude_query_string
              exclude_host              = each.value.path_matcher_route_rule_cache_key_policy_exclude_host
              included_query_parameters = each.value.path_matcher_route_rule_cache_key_policy_included_query_parameters
              included_header_names     = each.value.path_matcher_route_rule_cache_key_policy_included_header_names
              excluded_query_parameters = each.value.path_matcher_route_rule_cache_key_policy_excluded_query_parameters
              included_cookie_names     = each.value.path_matcher_route_rule_cache_key_policy_included_cookie_names
            }
            negative_caching        = each.value.path_matcher_route_rule_cdn_policy_negative_caching
            negative_caching_policy = each.value.path_matcher_route_rule_cdn_policy_negative_caching_policy
            signed_request_mode     = each.value.path_matcher_route_rule_cdn_policy_signed_request_mode
            signed_request_keyset   = each.value.path_matcher_route_rule_cdn_policy_signed_request_keyset
          }
          url_rewrite {
            path_prefix_rewrite   = each.value.path_matcher_route_rule_route_action_url_rewrite_path_prefix_rewrite
            host_rewrite          = each.value.path_matcher_route_rule_route_action_url_rewrite_host_rewrite
            path_template_rewrite = each.value.path_matcher_route_rule_route_action_url_rewrite_path_template_rewrite
          }
          cors_policy {
            max_age           = each.value.path_matcher_route_rule_route_action_cors_policy_max_age
            allow_credentials = each.value.path_matcher_route_rule_route_action_cors_policy_allow_credentials
            allow_origins     = each.value.path_matcher_route_rule_route_action_cors_policy_allow_origins
            allow_methods     = each.value.path_matcher_route_rule_route_action_cors_policy_allow_methods
            allow_headers     = each.value.path_matcher_route_rule_route_action_cors_policy_allow_headers
            expose_headers    = each.value.path_matcher_route_rule_route_action_cors_policy_expose_headers
            disabled          = each.value.path_matcher_route_rule_route_action_cors_policy_disabled
          }
        }
      }
    }
  }

  # dynamic routing {
  #   for_each = var.routing
  #   content {
  #     dynamic host_rule {
  #         for_each = var.host_rule
  #         content {
  #             hosts = var.host_rule["hosts"]
  #             path_matcher = var.host_rule["pathMatcher"]
  #         }
  #     }
  #     dynamic path_matcher {
  #         for_each = var.path_matcher
  #         content {
  #             name = var.path_matcher["name"]
  #             dynamic route_rule {
  #                 for_each = var.route_rule
  #                 content {
  #                     priority =  var.route_rule["priority"]
  #                     dynamic match_rule {
  #                         for_each = var.match_rule
  #                         content {

  #                         }
  #                     }
  #                 }
  #             }
  #         }
  #     }
  #   }
  # }
}