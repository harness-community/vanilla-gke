variable "gcp_project" {
  description = "The Google Cloud Project"
}

variable "gcp_region" {
  description = "The Google Cloud Region where the cluster will be created"
  default     = "asia-south1"
}

variable "cluster_name" {
  description = "The GKE cluster name"
  default     = "wi-demos"
}

variable "gke_num_nodes" {
  default     = 2
  description = "Number of GKE nodes"
}

# gcloud compute machine-types list
variable "machine_type" {
  description = "The Google Cloud machine types for each cluster node"
  # https://cloud.google.com/compute/docs/general-purpose-machines#e2_machine_types
  default = "e2-standard-4"
}

variable "kubernetes_version" {
  description = "The kubernetes versions of the GKE clusters"
  # kubernetes version to use, major.minor
  default = "1.24."
}

variable "release_channel" {
  description = "The GKE release channel to use"
  type        = string
  default     = "stable"
}

variable "gitlab_agent_namespace" {
  default     = "gitlab-agent"
  description = "Kubernetes namespace to install the Agent"
}

variable "gitlab_agent_token" {
  description = "Agent token (provided when registering an Agent in GitLab)"
  sensitive   = true
}

variable "gitlab_kas_address" {
  description = "Agent Server address (provided when registering an Agent in GitLab)"
}

variable "flux_system_namespace" {
  description = "The Kubernetes namespace where the flux is installed"
  default     = "flux-system"
}

variable "flux_source_controller_ksa" {
  description = "The Kubernetes namespace where the flux is installed"
  default     = "source-controller"
}

variable "app_namespace" {
  description = "The Kubernetes namespace where the lingua-greeter demo application will be deployed"
  default     = "demo-apps"
}

variable "app_ksa" {
  description = "The Kubernetes service account that will be used to run the lingua-greeter deployment"
  default     = "lingua-greeter"
}