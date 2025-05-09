# Resource to create a network endpoint group (NEG) for Cloud Run
resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  name                   = "cloudrun-neg"
  network_endpoint_type  = "SERVERLESS"
  region                 = var.region

  cloud_run {
    service = var.cloud_run_service
  }
}

# Loadbalancer backend service to integrate the NEG 
resource "google_compute_backend_service" "default" {
  name                            = "cloudrun-backend"
  load_balancing_scheme           = "EXTERNAL"
  protocol                        = "HTTP"
  enable_cdn                      = false
  timeout_sec                     = 30
  connection_draining_timeout_sec = 0

  backend {
    group = google_compute_region_network_endpoint_group.cloudrun_neg.id
  }
}


# URL mapping distributing traffic to the backend service
resource "google_compute_url_map" "default" {
  name            = "cloudrun-url-map"
  default_service = google_compute_backend_service.default.id
}

#HTTP proxy to handle incoming traffic and forward to the URL map
resource "google_compute_target_http_proxy" "default" {
  name    = "cloudrun-http-proxy"
  url_map = google_compute_url_map.default.id
}


# Allocate a global IP address for the load balancer
resource "google_compute_global_address" "default" {
  name = "cloudrun-ip"
}


# Resource for the forwarding rule to direct traffic to the HTTP proxy
resource "google_compute_global_forwarding_rule" "default" {
  name       = "cloudrun-forwarding-rule"
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
  ip_address = google_compute_global_address.default.address
}
