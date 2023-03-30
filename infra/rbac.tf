resource "google_service_account" "gar_reader_sa" {
  account_id   = "gar-reader"
  display_name = "Service Account that will be used to download artifacts from GAR"
}

resource "google_service_account_iam_binding" "workload_identity_gar_iam" {
  service_account_id = google_service_account.gar_reader_sa.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${var.gcp_project}.svc.id.goog[${var.flux_system_namespace}/${var.flux_source_controller_ksa}]",
  ]
}

resource "google_project_iam_binding" "iam_binding_gar_reader" {
  project = var.gcp_project
  role    = "roles/artifactregistry.reader"

  members = [
    google_service_account.gar_reader_sa.member,
  ]
}