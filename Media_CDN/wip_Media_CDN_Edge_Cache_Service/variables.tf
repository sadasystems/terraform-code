# REQUIRED PARAMETERS
variable "gcp_project_id" {
  description = "Project in which GCS Bucket Resources will be created."
  type        = string
}

variable "media_cdn_service_name" {
  description = "Name of the Media CDN Edge Cache Service resource."
  type        = string
}

variable "routing" {
  description = "routing"
  default     = null
  type        = any
}

variable "host_rule" {
  description = "External networks that can access the MySQL master instance through HTTPS."
  type = list(object({
    hosts        = list(string)
    path_matcher = string
  }))
  default = []
}

variable "path_matcher" {
  description = "path_matcher"
  default     = []
  type = list(object({
    name = string
    route_rule = list(object({
      priority = string
      origin   = string
      match_rule = list(object({
        ignore_case         = string
        prefix_match        = string
        full_path_match     = string
        path_template_match = string
      }))
    }))
  }))
}

# variable "match_rule" {
#   description = "match_rule"
#   default = null
#   type = any
# }

variable "route_action" {
  description = "route_action"
  default     = null
  type        = any
}

variable "cdn_policy" {
  description = "cdn_policy"
  default     = null
  type        = any
}

variable "header_action" {
  description = "header_action"
  default     = null
  type        = any
}

variable "response_header_to_add" {
  description = "response_header_to_add"
  default     = null
  type        = any
}



# variable "" {
#   description = ""
#   default = 
#   type = list(map{

#   })
# }

# variable "routing" {
#   description = "Routing Blocks"
#   type = list(object({
#     routing_host_rule_description  = string
#     routing_host_rule_hosts        = list(string)
#     routing_host_rule_path_matcher = string

#     # path matcher
#     route_rule_origin = string

#     # url redirect
#     route_rule_url_redirect_host_redirect          = string
#     route_rule_url_redirect_path_redirect          = string
#     route_rule_url_redirect_prefix_redirect        = string
#     route_rule_url_redirect_redirect_response_code = string
#     route_rule_url_redirect_https_redirect         = string
#     route_rule_url_redirect_strip_query            = string

#     # route rule
#     path_matcher_route_rule_priority    = number
#     path_matcher_route_rule_description = string

#     # match rule
#     path_matcher_route_rule_match_rule_ignore_case     = string
#     path_matcher_route_rule_match_rule_prefix_match    = string
#     path_matcher_route_rule_match_rule_full_path_match = string

#     # header match
#     path_matcher_route_rule_match_rule_header_match_header_name   = string
#     path_matcher_route_rule_match_rule_header_match_present_match = string
#     path_matcher_route_rule_match_rule_header_match_exact_match   = string
#     path_matcher_route_rule_match_rule_header_match_prefix_match  = string
#     path_matcher_route_rule_match_rule_header_match_suffix_match  = string
#     path_matcher_route_rule_match_rule_header_match_invert_match  = string

#     # query parameter match
#     path_matcher_route_rule_match_rule_query_parameter_match_name          = string
#     path_matcher_route_rule_match_rule_query_parameter_match_present_match = string
#     path_matcher_route_rule_match_rule_query_parameter_match_exact_match   = string

#     # req header to add
#     path_matcher_route_rule_match_header_action_response_header_to_add_header_name  = string
#     path_matcher_route_rule_match_header_action_response_header_to_add_header_value = string
#     path_matcher_route_rule_match_header_action_response_header_to_add_replace      = string

#     # response header to add
#     path_matcher_route_rule_match_header_action_response_header_to_add_header_name  = string
#     path_matcher_route_rule_match_header_action_response_header_to_add_header_value = string
#     path_matcher_route_rule_match_header_action_response_header_to_add_replace      = string

#     # request header to remove
#     path_matcher_route_rule_match_header_action_request_header_to_remove_header_name  = string
#     path_matcher_route_rule_match_header_action_request_header_to_remove_header_value = string
#     path_matcher_route_rule_match_header_action_request_header_to_remove_replace      = string

#     # response header to remove
#     path_matcher_route_rule_match_header_action_response_header_to_remove_header_name  = string
#     path_matcher_route_rule_match_header_action_response_header_to_remove_header_value = string
#     path_matcher_route_rule_match_header_action_response_header_to_remove_replace      = string

#     # route action
#     # cdn policy
#     path_matcher_route_rule_cdn_policy_cache_mode  = string
#     path_matcher_route_rule_cdn_policy_client_ttl  = string
#     path_matcher_route_rule_cdn_policy_default_ttl = string
#     path_matcher_route_rule_cdn_policy_max_ttl     = string

#     # cache key policy
#     path_matcher_route_rule_cache_key_policy_include_protocol          = string
#     path_matcher_route_rule_cache_key_policy_exclude_query_string      = string
#     path_matcher_route_rule_cache_key_policy_exclude_host              = string
#     path_matcher_route_rule_cache_key_policy_included_query_parameters = string
#     path_matcher_route_rule_cache_key_policy_included_header_names     = string
#     path_matcher_route_rule_cache_key_policy_excluded_query_parameters = string
#     path_matcher_route_rule_cache_key_policy_included_cookie_names     = string

#     path_matcher_route_rule_cdn_policy_negative_caching        = string
#     path_matcher_route_rule_cdn_policy_negative_caching_policy = string
#     path_matcher_route_rule_cdn_policy_signed_request_mode     = string
#     path_matcher_route_rule_cdn_policy_signed_request_keyset   = string

#     # url rewrite
#     path_matcher_route_rule_route_action_url_rewrite_path_prefix_rewrite   = string
#     path_matcher_route_rule_route_action_url_rewrite_host_rewrite          = string
#     path_matcher_route_rule_route_action_url_rewrite_path_template_rewrite = string

#     # cors policy
#     path_matcher_route_rule_route_action_cors_policy_max_age           = string
#     path_matcher_route_rule_route_action_cors_policy_allow_credentials = string
#     path_matcher_route_rule_route_action_cors_policy_allow_origins     = string
#     path_matcher_route_rule_route_action_cors_policy_allow_methods     = string
#     path_matcher_route_rule_route_action_cors_policy_allow_headers     = string
#     path_matcher_route_rule_route_action_cors_policy_expose_headers    = string
#     path_matcher_route_rule_route_action_cors_policy_disabled          = string
#   }))
# }

