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

output "env-dynamic-url" {
  value       = "https://${google_container_cluster.primary.endpoint}"
  description = "GKE Cluster Endpoint URL"
}

output "translator-service-account" {
  value       = length(google_service_account.translator_sa) == 0 ? "" : google_service_account.translator_sa.email
  description = "The Google Service Account 'translator'"
}

output "ksa-patch" {
  value = templatefile("templates/sa.tfpl", {
    serviceAccountName : "${var.app_ksa}"
    serviceAccountNamespace : "${var.app_namespace}",
    googleServiceAccountEmail : (
      length(google_service_account.translator_sa) == 0
      ? ""
      : "${google_service_account.translator_sa.email}"
    )
  })
  description = "The Kubernetes Service Account patch required for Workload Identity"
}




