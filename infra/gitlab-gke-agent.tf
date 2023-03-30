resource "helm_release" "gitlab_agent" {
  name = "gitlab-agent"

  repository = "https://charts.gitlab.io"
  chart      = "gitlab-agent"

  create_namespace = true
  namespace        = var.gitlab_agent_namespace

  set {
    name  = "image.tag"
    value = "v15.10.0"

  }
  set {
    name  = "config.kasAddress"
    value = var.gitlab_kas_address
  }

  set {
    name  = "config.token"
    value = var.gitlab_agent_token
  }
}
