# REQUIRED PARAMETERS
variable "connector_name" {
  description = "The name of the VPC Access Connector"
  type        = string
}

variable "vpc_name" {
  description = "GCP VPC name in which VPC Access Connector will be created."
  type        = string
}

variable "ip_cidr_range" {
  description = "The range of internal addresses that follows RFC 4632 notation. Example: 10.3.0.0/28."
  type        = string
}

variable "gcp_project_id" {
  description = "GCP Project in which VPC Access Connector will be created."
  type        = string
}

# OPTIONAL PARAMETERS
variable "machine_type" {
  description = "Machine type of VM Instance underlying connector."
  default     = "e2-micro"
  type        = string
}

variable "max_throughput" {
  description = "Maximum throughput of the connector in Mbps, must be greater than min_throughput"
  default     = 300
  type        = number
}

variable "min_throughput" {
  description = "Minimum throughput of the connector in Mbps."
  default     = 200
  type        = number
}

# TIMEOUT PARAMETERS
variable "connector_timeout" {
  description = "How long a VPC Access Connector creation operation is allowed to take before being considered a failure."
  default     = "28m"
  type        = string
}
