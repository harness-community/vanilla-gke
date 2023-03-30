data "google_compute_zones" "available" {
  region = var.gcp_region
}

data "google_container_engine_versions" "supported" {
  location       = local.google_zone
  version_prefix = var.kubernetes_version
}

data "google_client_config" "current" {}