module "avicii" {
  source                 = "../../../Media_CDN/Media_CDN_Edge_Cache_Service"
  project_id             = var.project_id
  media_cdn_service_name = "avicii"

  host_rule = [
    {
      hosts        = ["sslcert.tf-test.club"]
      path_matcher = "routes"
    },
    {
      hosts        = ["sslllllll.tf-test.club"]
      path_matcher = "roooooutes"
    }
  ]
  path_matcher = [
    {
      name = "routes"
      route_rule = [
        {
          priority = 1
          origin   = "cloud-storage-origin"
          match_rule = [
            {
              ignore_case         = true
              prefix_match        = "/home/nohome"
              full_path_match     = null
              path_template_match = null
              header_match = [
                {
                  header_name   = "default"
                  present_match = true
                  exact_match   = null
                  prefix_match  = null
                  suffix_match  = null
                  invert_match  = null
                }
              ]
              query_parameter_match = []
            },
            {
              ignore_case         = false
              prefix_match        = null
              full_path_match     = "/full/path"
              path_template_match = null
              header_match = [
                {
                  header_name   = "default-02"
                  present_match = null
                  exact_match   = "/exact_match"
                  prefix_match  = null
                  suffix_match  = null
                  invert_match  = null
                },
                {
                  header_name   = "default-03"
                  present_match = null
                  exact_match   = null
                  prefix_match  = "/prefix/match"
                  suffix_match  = null
                  invert_match  = null
                }
              ]
              query_parameter_match = [
                {
                  name          = "state"
                  exact_match   = "debug"
                  present_match = null
                }
              ]
            }
          ]
          route_action = []
          url_redirect = []
        },
        {
          priority = 4
          origin   = "loki"
          match_rule = [
            {
              ignore_case           = true
              prefix_match          = "/"
              full_path_match       = null
              path_template_match   = null
              header_match          = []
              query_parameter_match = []
            },
            {
              ignore_case         = false
              prefix_match        = "/home"
              full_path_match     = null
              path_template_match = null
              header_match = [
                {
                  header_name   = "default-02"
                  present_match = null
                  exact_match   = null
                  prefix_match  = null
                  suffix_match  = "/suffix/match"
                  invert_match  = true
                }
              ]
              query_parameter_match = [
                {
                  name          = "state-02"
                  present_match = true
                  exact_match   = null
                }
              ]
            }
          ]
          route_action = []
          url_redirect = []
        }
      ]
    },
    {
      name = "roooooutes"
      route_rule = [
        {
          priority = 3
          origin   = null
          match_rule = [
            {
              ignore_case           = true
              prefix_match          = null
              full_path_match       = null
              path_template_match   = "/*/*.mp4"
              header_match          = []
              query_parameter_match = []
            }
          ]
          route_action = [
            {
              cdn_policy = [
                {
                  cache_mode       = "CACHE_ALL_STATIC"
                  client_ttl       = "3600s"
                  default_ttl      = "3800s"
                  max_ttl          = "9000s"
                  negative_caching = true
                  negative_caching_policy = {
                    "500" = "3000s"
                  }
                  signed_request_mode   = "DISABLED"
                  signed_request_keyset = null
                },
              ]
              url_rewrite = [
                {
                  path_prefix_rewrite   = "/dev"
                  host_rewrite          = "dev.club"
                  path_template_rewrite = null
                }
              ]
              cors_policy = []
            },
          ]
          url_redirect = [
            {
              host_redirect          = "dummy-value.com"
              path_redirect          = null
              prefix_redirect        = null
              redirect_response_code = "FOUND"
              https_redirect         = true
              strip_query            = true
            }
          ]
        }
      ]
    }
  ]
}
