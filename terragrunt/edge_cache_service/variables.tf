variable "project" {
  type     = string
  nullable = false
}

variable "media_cdn_service_name" {
  type     = string
  nullable = false
}

variable "priority" {
  type     = string
  nullable = false
}

variable "media_cdn_origin_name" {
  type     = string
  nullable = false
}

variable "host_redirect" {
  type     = string
  nullable = false
}

variable "redirect_response_code" {
  type     = string
  nullable = false
}

variable "cache_mode" {
  type     = string
  nullable = false
}
