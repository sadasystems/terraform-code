module "avicii" {
  source                 = "../../../GoogleCloud/Media_CDN/Media_CDN_Edge_Cache_Service"
  gcp_project_id         = var.project_id
  media_cdn_service_name = "avicii"

  routing = [{
    host_rule = {
      "hosts"        = ["rohans.dev"]
      "path_matcher" = "rohan"
    }
    path_matcher = {
      "path_matcher_name" = "rohan"
      route_rule = {
        "priority" = "2"
        "origin"   = "spirits-tf"
        match_rule = {
          "prefix_match" = "/"
        }
        header_action = {
          response_header_to_add = {
            "header_name"  = "debug"
            "header_value" = "true"
          }
        }
        route_action = {
          cdn_policy = {
            cache_mode = "USE_ORIGIN_HEADERS"
          }
        }
      }
    }
    }
  ]
}
