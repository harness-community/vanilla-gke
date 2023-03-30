# This is used to set local variable google_zone.
resource "random_shuffle" "az" {
  input        = data.google_compute_zones.available.names
  result_count = 1
}

locals {
  google_zone = random_shuffle.az.result[0]
}

# GKE cluster
resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = local.google_zone
  min_master_version = data.google_container_engine_versions.supported.latest_master_version

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  release_channel {
    channel = upper(var.release_channel)
  }

  # workload identity config
  workload_identity_config {
    workload_pool = "${var.gcp_project}.svc.id.goog"
  }
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  location   = local.google_zone
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.gcp_project
    }

    # preemptible  = true
    machine_type = var.machine_type
    tags         = ["gke-node", "${var.gcp_project}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
