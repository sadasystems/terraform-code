module "spirits" {
  source                = "../../../Media_CDN/Media_CDN_Edge_Cache_Origin"
  gcp_project_id        = var.project_id
  media_cdn_origin_name = "spirits"

  # Only one of the below three need to be provided.
  gcs_bucket_name = "gcs-for-media-cdn"
  # ip_address_origin        = "10.0.0.1"
  # fqdn_origin              = "https://rohans.dev"

  #   retry_conditions = ["CONNECT_FAILURE", "HTTP_5XX", "GATEWAY_ERROR"]
  #   timeout = {
  #     connect_timeout = "10s"
  #     max_attempts_timeout = "20s"
  #     response_timeout = "60s"
  #     read_timeout = "5s"
  #   }

    create_fallback_origin = true
}
