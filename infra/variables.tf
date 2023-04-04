variable "gcp_project" {
  description = "The Google Cloud Project"
  sensitive   = true
}

variable "gcp_region" {
  description = "The Google Cloud Region where the cluster will be created"
  default     = "asia-south1"
}

variable "cluster_name" {
  description = "The GKE cluster name"
  default     = "vanilla"
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

variable "install_gitlab_agent" {
  description = "Install gitlab agent.**IMPORTANT** When you enable this, please make sure to provide the value for `gitlab_agent_token`."
  type        = bool
  default     = false

}
variable "gitlab_agent_namespace" {
  default     = "kube-system"
  description = "Kubernetes namespace to install the GitLab Agent"
}

variable "gitlab_agent_name" {
  default     = "gitlab-agent"
  description = "The GitLab Agent name. This value will be used to set the Helm release name of the chart"
}

variable "gitlab_agent_token" {
  description = "GitLab Agent token (provided when registering an Agent in GitLab)"
  sensitive   = true
  default = ""
}

variable "gitlab_kas_address" {
  description = "GitLab Agent Server address (provided when registering an Agent in GitLab)"
  default     = "wss://kas.gitlab.com"
}

variable "gitlab_agent_image_tag" {
  description = "GitLab Agent image tag"
  default     = "v15.10.0"
}

variable "gitlab_agent_replicas" {
  default     = 1
  description = "The number of replicas for the agent"

}

