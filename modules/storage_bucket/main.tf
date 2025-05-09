#code to create a storage bucket

resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.location
}
