# REQUIRED PARAMETERS
variable "cloud_func_name" {
  description = "Name of GCP Cloud Function to be created."
  type        = string
}

variable "cloud_func_runtime" {
  description = "The runtime in which the function is going to run. Eg. 'nodejs16', 'python39', 'dotnet3', 'go116', 'java11', 'ruby30', 'php74', etc. Visit link for full list: https://cloud.google.com/functions/docs/concepts/exec#runtimes"
  type        = string
}

variable "gcp_project_id" {
  description = "Project in which GCP Resources will be created."
  type        = string
}

variable "region" {
  description = "GCP Region in which GCP Resources will be created."
  type        = string
}

# OPTIONAL PARAMETERS
variable "connector_name" {
  description = "The name of the VPC Access Connector"
  default     = ""
  type        = string
}

variable "create_vpc_connector" {
  description = "Whether to create VPC Access Connector or not."
  default     = false
  type        = bool
}

variable "existing_vpc_conn_name" {
  description = "Name of existed or already created VPC Access Connector."
  default     = ""
  type        = string
}

variable "cidr_range" {
  description = "The range of internal addresses that follows RFC 4632 notation. Example: 10.132.0.0/28."
  default     = ""
  type        = string
}

variable "vpc_name" {
  description = "Name or self_link of the VPC network. Required if ip_cidr_range is set."
  default     = ""
  type        = string
}

variable "cloud_func_description" {
  description = "Description of the function."
  default     = ""
  type        = string
}

variable "available_memory_mb" {
  description = "Memory (in MB), available to the function. Possible values include 128, 256, 512, 1024, etc."
  default     = 256
  type        = number
}

variable "cloud_func_timeout" {
  description = "Timeout (in seconds) for the function. Cannot be more than 540 seconds."
  default     = 60
  type        = number
}

variable "cloud_func_entry_point" {
  description = "Name of the function that will be executed when the Google Cloud Function is triggered."
  default     = null
  type        = string
}

# Visit this link to understand Calling Cloud Functions: https://cloud.google.com/functions/docs/calling/
variable "event_trigger" {
  description = "A source that fires events in response to a condition in another service. Either event_trigger or trigger_http could be used. Visit link: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function#nested_event_trigger"
  type = object({
    event_type = string
    resource   = string
  })
  default = {
    event_type = ""
    resource   = ""
  }
}

variable "cloud_func_failure_retry" {
  description = "Whether the function should be retried on failure. Specifies policy for failed executions."
  default     = false
  type        = bool
}

variable "cloud_func_trigger_http" {
  description = "Any HTTP request to the endpoint will trigger function execution. Supported HTTP request types are: POST, PUT, GET, DELETE, and OPTIONS. Endpoint is returned as https_trigger_url. Either event_trigger or trigger_http could be used."
  default     = null
  type        = bool
}

variable "cloud_func_ingress_settings" {
  description = "String value that controls what traffic can reach the function. Allowed values are ALLOW_ALL, ALLOW_INTERNAL_AND_GCLB and ALLOW_INTERNAL_ONLY. Visit link: https://cloud.google.com/functions/docs/networking/network-settings#ingress_settings"
  default     = "ALLOW_ALL"
  type        = string
}

variable "cloud_func_labels" {
  description = "A set of key/value label pairs to assign to the function."
  default     = {}
  type        = map(any)
}

variable "env_vars" {
  description = "A set of key/value environment variable pairs to assign to the function."
  default     = {}
  type        = map(any)
}

variable "build_env_vars" {
  description = "A set of key/value environment variable pairs available during build time."
  default     = {}
  type        = map(any)
}

variable "sa_email" {
  description = "The email of the service account to be associated with cloud functions."
  default     = ""
  type        = string
}

variable "vpc_connector_egress_settings" {
  description = "The egress settings for the connector, controlling what traffic is diverted through it. Allowed values are ALL_TRAFFIC and PRIVATE_RANGES_ONLY. If unset, this field preserves the previously set value."
  default     = "PRIVATE_RANGES_ONLY"
  type        = string
}

variable "cloud_func_source_code_bucket_name" {
  description = "The GCS bucket containing the zip archive which contains the function. Either cloud_func_source_code_bucket_name or source_repo_url be used."
  default     = ""
  type        = string
}

variable "cloud_func_code_filename" {
  description = "The source archive object (file) in archive bucket. Either cloud_func_code_filename or source_repo_url be used."
  default     = ""
  type        = string
}

# variable "source_repo_url" {
#   description = "Represents parameters related to source repository where a function is hosted. It must match the pattern projects/{project}/locations/{location}/repositories/{repository}. Either cloud_func_source_code_bucket_name/cloud_func_code_filename or source_repo_url be used."
#   default     = ""
#   type        = string
# } 

variable "max_instances" {
  description = "The limit on the maximum number of function instances that may coexist at a given time."
  default     = null
  type        = number
}

variable "min_instances" {
  description = "The limit on the minimum number of function instances that may coexist at a given time."
  default     = null
  type        = number
}

variable "secret_env_vars" {
  description = "Secret environment variables configuration."
  default = {
    key     = ""
    secret  = ""
    version = ""
  }
  type = object({
    key     = string # Name of the environment variable.
    secret  = string # ID of the secret in secret manager (not the full resource name).
    version = string # Version of the secret.
  })
}

variable "sec_vols" {
  description = "Secret volumes configuration."
  default = {
    mount_path = ""
    secret     = ""
  }
  type = object({
    mount_path = string # The path within the container to mount the secret volume. For example, setting the mount_path as "/etc/secrets" would mount the secret value files under the "/etc/secrets" directory. This directory will also be completely shadowed and unavailable to mount any other secrets. Recommended mount paths: "/etc/secrets" Restricted mount paths: "/cloudsql", "/dev/log", "/pod", "/proc", "/var/log".
    secret     = string # ID of the secret in secret manager (not the full resource name).
  })
}

variable "sec_vols_versions" {
  description = "Secret volumes configuration. List of secret versions to mount for this secret. If empty, the 'latest' version of the secret will be made available in a file named after the secret under the mount point."
  type = object({
    path    = string # Relative path of the file under the mount path where the secret value for this version will be fetched and made available.
    version = string # Version of the secret
  })
  default = {
    path    = ""
    version = ""
  }
}

variable "public_func" {
  description = "Whether the GCP Cloud Functions will be public or private."
  default     = false
  type        = bool
}

variable "cloud_func_invoker" {
  description = "List of users emails that maybe allowed to invoke GCP Cloud Function. Requires \"var.public_func\" to be set to \"true\"."
  default     = []
  type        = list(string)
}

# TIMEOUT PARAMETERS
variable "connector_timeout" {
  description = "How long a VPC Access Connector creation operation is allowed to take before being considered a failure."
  default     = "28m"
  type        = string
}

variable "cloud_func_resource_timeout" {
  description = "How long a GCP Cloud Function creation operation is allowed to take before being considered a failure."
  default     = "10m"
  type        = string
}
