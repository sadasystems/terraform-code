output "instance_name" {
  value       = local.cloud_func_name
  description = "Name of GCP Cloud Functions."
}

output "cloud_func_id" {
  value       = google_cloudfunctions_function.cloud_func.id
  description = "An identifier for the resource with format {{name}}"
}

output "https_trigger_url" {
  value       = google_cloudfunctions_function.cloud_func.https_trigger_url
  description = "URL which triggers function execution. Returned only if trigger_http is used."
}

output "vpc_connector_id" {
  value       = google_vpc_access_connector.connector.*.id
  description = "an identifier for the resource with format projects/{{project}}/locations/{{region}}/connectors/{{name}}"
}

output "vpc_connector_self_link" {
  value       = google_vpc_access_connector.connector.*.self_link
  description = "The fully qualified name of VPC Access Connector."
}
