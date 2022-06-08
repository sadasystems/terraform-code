output "vpc_connector_id" {
  value       = google_vpc_access_connector.connector.id
  description = "an identifier for the resource with format projects/{{project}}/locations/{{region}}/connectors/{{name}}"
}

output "vpc_connector_self_link" {
  value       = google_vpc_access_connector.connector.self_link
  description = "The fully qualified name of VPC Access Connector."
}
