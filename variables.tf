# Variable declarations for the project settings

# The GCP project ID
variable "project" {
  description = "project ID"
  type        = string
  default     = "bluewindow"
}


# The region to deploy resources
variable "region" {
  description = "Region to deploy resources"
  type        = string
  default     = "us-central1"
}
