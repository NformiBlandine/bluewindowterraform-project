# Variables for the Cloud Run service module

# The name of the Cloud Run service
variable "service_name" {

  type = string
}
#region
variable "region" {
  type = string
}
#image
variable "image" {
  type = string
}
#project
variable "project" {
  type = string
  default = "bluewindow"
}
