# Resource to deploy a Cloud Run service
resource "google_cloud_run_service" "default" {
  name     = var.service_name  # Name of the Cloud Run service (passed from main.tf)
  location = var.region        # Region for the Cloud Run service
  autogenerate_revision_name = true  # Automatically generate a new revision name for the service

  template {
    spec {
      containers {
        image = var.image
        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "invoker" {
  location = google_cloud_run_service.default.location
  project  = var.project
  service  = google_cloud_run_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"

  depends_on = [google_cloud_run_service.default]
}
