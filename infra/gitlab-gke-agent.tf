resource "helm_release" "gitlab_agent" {
  name = var.gitlab_agent_name

  repository = "https://charts.gitlab.io"
  chart      = "gitlab-agent"

  create_namespace = true
  namespace        = var.gitlab_agent_namespace


  values = [
    templatefile("${path.module}/templates/values.tfpl", {
      agentImageTag   = "${gitlab_agent_image_tag}"
      agentKasAddress = "${var.gitlab_kas_address}"
      agentReplicas   = "${var.gitlab_agent_replicas}"
      agentToken      = "${var.gitlab_agent_token}"

    })
  ]
}