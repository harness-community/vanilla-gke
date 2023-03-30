output "region" {
  value       = var.gcp_region
  description = "Google Cloud Region where the cluster is provisioned"
}

output "project-name" {
  value       = var.gcp_project
  description = "Google Cloud Project Name"
  sensitive   = true
}

output "zone" {
  value       = local.google_zone
  description = "Google Cloud Zone where the cluster is provisioned"
}

output "kubernetes-cluster-name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}

output "gke-endpoint-url" {
  value       = "https://${google_container_cluster.primary.endpoint}"
  description = "GKE Cluster Endpoint URL"
}
