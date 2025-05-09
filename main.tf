# Provider configuration to authenticate and deploy resources to Google Cloud Platform

provider "google" {
  project = var.project
  region  = var.region
}
#modules for the project


module "sql_instance" {
  source = "./modules/sql_instance"
  region = var.region
  name   = "mysql"
}

module "storage_bucket" {
  source      = "./modules/storage_bucket"
  bucket_name = "blue-window-nformi3023-io"
  location    = var.region
}

module "cloud_run" {
  source        = "./modules/cloud_run"
  region        = var.region
  image         = "gcr.io/bluewindow/demo:nformiblandine-27e49388b1"
  service_name  = "cloudrun-srv"
}

module "load_balancer" {
  source                = "./modules/load_balancer"
  region                = var.region
  cloud_run_service     = module.cloud_run.service_name
}
