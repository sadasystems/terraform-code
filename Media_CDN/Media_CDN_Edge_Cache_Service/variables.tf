# REQUIRED PARAMETERS
variable "project_id" {
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
  default = []
  # default     = [{
  #   name = ""
  #   route_rule = [{
  #     priority = 1
  #     origin = "default"
  #     match_rule = [{
  #       ignore_case = false
  #       prefix_match = ""
  #       full_path_match = ""
  #       path_template_match = ""
  #       header_match = [{
  #         header_name = "default"
  #         present_match = false
  #         exact_match   = ""
  #         prefix_match  = ""
  #         suffix_match  = ""
  #         invert_match  = false
  #       }]
  #       query_parameter_match = [{
  #         name          = "default"
  #         present_match = false
  #         exact_match   = ""
  #       }]
  #     }]
  #     route_action = [{
  #       cdn_policy = [{
  #         cache_mode              = ""
  #         client_ttl              = ""
  #         default_ttl             = ""
  #         max_ttl                 = ""
  #         negative_caching        = false
  #         negative_caching_policy = {}
  #         signed_request_mode     = ""
  #         signed_request_keyset   = ""
  #       }]
  #       url_rewrite = [{
  #         path_prefix_rewrite   = ""
  #         host_rewrite          = ""
  #         path_template_rewrite = ""
  #       }]
  #       cors_policy = [{
  #         max_age           = ""
  #         allow_credentials = false
  #         allow_headers     = []
  #         allow_methods     = []
  #         allow_origins     = []
  #         expose_headers    = []
  #         disabled          = false
  #       }]
  #     }]
  #     url_redirect = {
  #       host_redirect = ""
  #       path_redirect = ""
  #       prefix_redirect = ""
  #       redirect_response_code = "FOUND"
  #       https_redirect = true
  #       strip_query = true
  #     }
  #   }]
  # }]
  type = list(object({
    name = string
    route_rule = list(object({
      priority = number
      origin   = string
      match_rule = list(object({
        ignore_case         = bool
        prefix_match        = string
        full_path_match     = string
        path_template_match = string
        header_match = list(object({
          header_name   = string
          present_match = bool
          exact_match   = string
          prefix_match  = string
          suffix_match  = string
          invert_match  = bool
        }))
        query_parameter_match = list(object({
          name          = string
          present_match = bool
          exact_match   = string
        }))
      }))
      route_action = list(object({
        cdn_policy = list(object({
          cache_mode              = string
          client_ttl              = string
          default_ttl             = string
          max_ttl                 = string
          negative_caching        = bool
          negative_caching_policy = map(string)
          signed_request_mode     = string
          signed_request_keyset   = string
        }))
        url_rewrite = list(object({
          path_prefix_rewrite   = string
          host_rewrite          = string
          path_template_rewrite = string
        }))
        cors_policy = list(object({
          max_age           = string
          allow_credentials = bool
          allow_headers     = list(string)
          allow_methods     = list(string)
          allow_origins     = list(string)
          expose_headers    = list(string)
          disabled          = bool
        }))
      }))
      url_redirect = list(object({
        host_redirect          = string
        path_redirect          = string
        prefix_redirect        = string
        redirect_response_code = string
        https_redirect         = bool
        strip_query            = bool
      }))
    }))
  }))
}

variable "disable_http2" {
  description = "Enable/Disable HTTP2 Protocol for Media CDN."
  default     = false
  type        = bool
}

variable "disable_quic" {
  description = "Enable/Disable QUIC Protocol for Media CDN."
  default     = false
  type        = bool
}

variable "require_tls" {
  description = "Require TLS (HTTPS) for all clients connecting to this service. Clients who connect over HTTP (port 80) will receive a HTTP 301 to the same URL over HTTPS (port 443). You must have at least one (1) edgeSslCertificate specified to enable this."
  default     = false
  type        = bool
}

variable "edge_ssl_certificates" {
  description = "URLs to sslCertificate resources that are used to authenticate connections between users and the Media CDN. Note that only 'global' certificates with a 'scope' of 'EDGE_CACHE' can be attached to an Media CDN."
  default     = []
  type        = list(string)
}

variable "edge_security_policy" {
  description = "Resource URL that points at the Cloud Armor edge security policy that is applied on each request against the Media CDN."
  default     = ""
  type        = string
}

variable "log_config" {
  description = "Variable to enable Media CDN logging along with sampling rate of requests where 1.0 means all logged requests are reported and 0.0 means no logged requests are reported."
  default = {
    enable      = false
    sample_rate = null
  }
  type = object({
    enable      = bool
    sample_rate = number
  })
}
