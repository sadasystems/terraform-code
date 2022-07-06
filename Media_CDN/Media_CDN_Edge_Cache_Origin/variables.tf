# REQUIRED PARAMETERS
variable "gcp_project_id" {
  description = "Project in which GCS Bucket Resources will be created."
  type        = string
}

variable "media_cdn_origin_name" {
  description = "Name of the Media CDN Edge Cache Origin resource."
  type        = string
}

# OPTIONAL PARAMETERS
variable "create_fallback_origin" {
  description = "Whether to create fallback Media CDN Cache origin or not, if supplied true; will create a fallback origin where fallback media origin will be used when main one cannot be reached."
  default     = false
  type        = bool
}

variable "gcs_bucket_name" {
  description = "An variable to provide if Media CDN Cache Origin is GCS Bucket Name. Can't work with neither ip_address_origin nor fqdn_origin."
  default     = ""
  type        = string
}

variable "ip_address_origin" {
  description = "An variable to provide if Media CDN Cache Origin is IP Address, IPv4 and IPv6; both are accepted. Can't work with neither fqdn_origin nor gcs_bucket_name."
  default     = ""
  type        = string
}

variable "fqdn_origin" {
  description = "An variable to provide if Media CDN Cache Origin is External. Can't work with neither ip_address_origin nor gcs_bucket_name."
  default     = ""
  type        = string
}

variable "max_attempts" {
  description = "The maximum number of attempts to cache fill from this origin. Another attempt is made when a cache fill fails with one of the retryConditions."
  default     = 3
  type        = number
}

variable "protocol" {
  description = "The protocol to use to connect to the configured origin."
  default     = "HTTP2"
  type        = string
}

variable "port" {
  description = "The port to connect to the origin on."
  default     = 443
  type        = number
}

variable "retry_conditions" {
  description = "Specifies one or more retry conditions for the configured origin. If the failure mode during a connection attempt to the origin matches the configured retryCondition(s), the origin request will be retried up to maxAttempts times. Visit for more: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/network_services_edge_cache_origin#retry_conditions"
  default     = ["CONNECT_FAILURE"]
  type        = list(string)
}

variable "timeout" {
  description = "The connection and HTTP timeout configuration for this origin."
  default = {
    connect_timeout      = ""
    max_attempts_timeout = ""
    response_timeout     = ""
    read_timeout         = ""
  }
  type = object({
    connect_timeout      = string
    max_attempts_timeout = string
    response_timeout     = string
    read_timeout         = string
  })
}

# timeouts variables
variable "media_cdn_origin_timeout" {
  description = "How long a Media CDN operations is allowed to take before being considered a failure."
  default     = "90m"
  type        = string
}
