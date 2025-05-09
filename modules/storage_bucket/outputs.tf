#output after the bucket is created
output "bucket_name" {
  value = google_storage_bucket.bucket.name
}
