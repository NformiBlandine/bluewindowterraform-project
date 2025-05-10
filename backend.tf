# Configures the backend for Terraform state storage using Google Cloud Storage
terraform {
  backend "gcs" {
    bucket = "bluewindow-terraform-nformi"
    prefix = "terraform/state"
  }
}
