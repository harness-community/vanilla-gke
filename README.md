# Flux GKE Bootstrap

How to bootstrap [flux](https://fluxcd.io) with [Google Kubernetes Engine(GKE)](https://cloud.google.com/kubernetes-engine). The bootstrap happens via GitLab CI that receives a [webhook trigger](https://docs.gitlab.com/ee/ci/triggers/#use-a-webhook-payload) from Terraform Cloud once the GKE cluster is provisioned using [terraform](https://terraform.build).

> IMPORTANT: WORK IN PROGRESS

## Pre-requisites

- [Google Cloud Account](https://cloud.google.com)
  - With a Service Account with roles
    - `Kubernetes Engine Admin`  - to create GKE cluster
    - `Service Account User`     - to use other needed service accounts
    - `Service Account Admin`    - to use create new service accounts
    - `Project IAM Admin`        - to create/update IAM Policy Binding
    - `Compute Network Admin`    - to create the VPC networks that will be used by the GitLab Runner GKE
- [Terraform Cloud Account](https://app.terraform.io/public/signup/account)
- [Google Cloud SDK](https://cloud.google.com/sdk)
- [direnv](https://direnv.net)(Optional)

## Clone and Fork Repo

Using [glab cli](https://gitlab.com/gitlab-org/cli)

```shell
glab repo fork kameshsampath/flux-gke --clone
cd runner-gke
export DEMO_HOME="$PWD"
```

## GitLab CI/CD Variables

>**NOTE**: the section will be updated with more details

Set the following variables under **Project** --> **Settings** --> **CI/CD**,

![GitLab CI/CD Variables](/docs/images/gitlab-cicd-variables.png)

## Terraform Cloud Variables

Set the following variables under **Workspace** --> **Variables**,

![Terraform Variables](/docs/images/tfcloud-variables.png)
![Terraform Variables](/docs/images/tfcloud-variables-2.png)

The following sections details the inputs and outputs that are configurable as part of the tutorial's terraform automation,

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The GKE cluster name | `string` | `"gitops"` | no |
| <a name="input_flux_source_controller_ksa"></a> [flux\_source\_controller\_ksa](#input\_flux\_source\_controller\_ksa) | The Kubernetes namespace where the flux is installed | `string` | `"source-controller"` | no |
| <a name="input_flux_system_namespace"></a> [flux\_system\_namespace](#input\_flux\_system\_namespace) | The Kubernetes namespace where the flux is installed | `string` | `"flux-system"` | no |
| <a name="input_gcp_project"></a> [gcp\_project](#input\_gcp\_project) | The Google Cloud Project | `any` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | The Google Cloud Region where the cluster will be created | `string` | `"asia-south1"` | no |
| <a name="input_gitlab_agent_image_tag"></a> [gitlab\_agent\_image\_tag](#input\_gitlab\_agent\_image\_tag) | GitLab Agent image tag | `string` | `"v15.10.0"` | no |
| <a name="input_gitlab_agent_name"></a> [gitlab\_agent\_name](#input\_gitlab\_agent\_name) | The GitLab Agent name. This value will be used to set the Helm release name of the chart | `string` | `"gitlab-agent"` | no |
| <a name="input_gitlab_agent_namespace"></a> [gitlab\_agent\_namespace](#input\_gitlab\_agent\_namespace) | Kubernetes namespace to install the GitLab Agent | `string` | `"kube-system"` | no |
| <a name="input_gitlab_agent_replicas"></a> [gitlab\_agent\_replicas](#input\_gitlab\_agent\_replicas) | The number of replicas for the agent | `number` | `1` | no |
| <a name="input_gitlab_agent_token"></a> [gitlab\_agent\_token](#input\_gitlab\_agent\_token) | GitLab Agent token (provided when registering an Agent in GitLab) | `any` | n/a | yes |
| <a name="input_gitlab_kas_address"></a> [gitlab\_kas\_address](#input\_gitlab\_kas\_address) | GitLab Agent Server address (provided when registering an Agent in GitLab) | `string` | `"wss://kas.gitlab.com"` | no |
| <a name="input_gke_num_nodes"></a> [gke\_num\_nodes](#input\_gke\_num\_nodes) | Number of GKE nodes | `number` | `2` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The kubernetes versions of the GKE clusters | `string` | `"1.24."` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | The Google Cloud machine types for each cluster node | `string` | `"e2-standard-4"` | no |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | The GKE release channel to use | `string` | `"stable"` | no |

## Connect GitLab Repoistory To Terraform Cloud

Connect GitLab repository `$DEMO_HOME` with Terraform Cloud using the **Workspace** --> **Settings** --> **Version Control**,

![Terraform Cloud Version Control](/docs/images/tfcloud-vcs.png)

Once you have connected your repo with Terraform cloud assuming you are using default settings, every push the GitLab repo will trigger a terraform `apply`.

>**NOTE**: Adjust other settings nameley `VCS Trigger`, `Apply Method` etc., as per your needs.

## Configure GitLab Trigger

__TODO__

## Configure Terrafrom Notification

__TODO__

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gke-endpoint-url"></a> [gke-endpoint-url](#output\_gke-endpoint-url) | GKE Cluster Endpoint URL |
| <a name="output_kubernetes-cluster-name"></a> [kubernetes-cluster-name](#output\_kubernetes-cluster-name) | GKE Cluster Name |
| <a name="output_project-name"></a> [project-name](#output\_project-name) | Google Cloud Project Name |
| <a name="output_region"></a> [region](#output\_region) | Google Cloud Region where the cluster is provisioned |
| <a name="output_zone"></a> [zone](#output\_zone) | Google Cloud Zone where the cluster is provisioned |

## License

[Apache License](./../LICENSE)

