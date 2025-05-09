# Output to return the name of the created Cloud Run services
output "service_name" {
  value = google_cloud_run_service.default.name
}
