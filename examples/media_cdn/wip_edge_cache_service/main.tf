locals {
  
}
module "avicii" {
  source                 = "../../../Media_CDN/wip_Media_CDN_Edge_Cache_Service"
  gcp_project_id         = var.project_id
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
          priority = "1"
          origin   = "cloud-storage-origin"
          match_rule = [
            {
              ignore_case  = "true"
              prefix_match = "/home/nohome"
            },
            {
              ignore_case  = "false"
              prefix_match = "/home"
            }
          ]
        },
        {
          priority = "4"
          origin   = "loki"
          match_rule = [
            {
              ignore_case  = "true"
              prefix_match = "/"
            },
            {
              ignore_case  = "false"
              prefix_match = "/home"
            }
          ]
        }
      ]
    },
    {
      name = "roooooutes"
      route_rule = [
        {
          priority = "3"
          origin   = "loki"
          match_rule = [
            {
              ignore_case  = "true"
              prefix_match = "/"
            }
          ]
        }
      ]
    }
  ]
  # routing = [{
  #   host_rule = {
  #     "hosts"        = ["rohans.dev"]
  #     "path_matcher" = "rohan"
  #   },
  #   host_rule = {
  #     "hosts"        = ["sslcert.tf-test2.club"]
  #     "path_matcher" = "routes"
  #   }
  #   path_matcher = {
  #     "path_matcher_name" = "rohan"
  #     route_rule = {
  #       "priority" = "2"
  #       "origin"   = "spirits-tf"
  #       match_rule = {
  #         "prefix_match" = "/"
  #       }
  #       header_action = {
  #         response_header_to_add = {
  #           "header_name"  = "debug"
  #           "header_value" = "true"
  #         }
  #       }
  #       route_action = {
  #         cdn_policy = {
  #           cache_mode = "USE_ORIGIN_HEADERS"
  #         }
  #       }
  #     }
  #   }
  #   }
  # ]
}
