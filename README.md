# GKE Provision Template

Template repository to provision [Google Kubernetes Engine(GKE)](https://cloud.google.com/kubernetes-engine) using [terraform](https://terraform.build). The terraform provision uses [Terraform Cloud](https://app.terraform.io/public/signup/account) as the backend.

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
glab repo fork kameshsampath/vanilla-gke --clone
cd runner-gke
export DEMO_HOME="$PWD"
```

## Terraform Cloud Variables

Set the following variables under **Workspace** --> **Variables**,

![Terraform Variables](/docs/images/tfcloud-variables.png)
![Terraform Variables](/docs/images/tfcloud-variables-2.png)

## Set environment

```shell
export GCP_PROJECT="your awesome project"
export GSA_KEY_FILE="path to key file"
```

## Create SA

```shell
gcloud iam service-accounts create gke-user \
  --description "GKE User" \
  --display-name "gke-user"
```

## IAM Binding

Add permissions to the user to be able to provision kubernetes resources,

```shell
gcloud projects add-iam-policy-binding $GCP_PROJECT \
  --member="serviceAccount:$GSA_NAME@$GCP_PROJECT.iam.gserviceaccount.com" \
  --role="roles/container.admin"
```

## Download And Save GSA Key

> IMPORTANT: Only security admins can create the JSON keys. Ensure the Google Cloud user you are using has **Security Admin** role.

```shell
gcloud iam service-accounts keys create "${GSA_KEY_FILE}" \
    --iam-account="gke-user@${GCP_PROJECT}.iam.gserviceaccount.com"
```

The following sections details the inputs and outputs that are configurable as part of the tutorial's terraform automation,

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The GKE cluster name | `string` | `"vanilla"` | no |
| <a name="input_gcp_project"></a> [gcp\_project](#input\_gcp\_project) | The Google Cloud Project | `any` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | The Google Cloud Region where the cluster will be created | `string` | `"asia-south1"` | no |
| <a name="input_gitlab_agent_image_tag"></a> [gitlab\_agent\_image\_tag](#input\_gitlab\_agent\_image\_tag) | GitLab Agent image tag | `string` | `"v15.10.0"` | no |
| <a name="input_gitlab_agent_name"></a> [gitlab\_agent\_name](#input\_gitlab\_agent\_name) | The GitLab Agent name. This value will be used to set the Helm release name of the chart | `string` | `"gitlab-agent"` | no |
| <a name="input_gitlab_agent_namespace"></a> [gitlab\_agent\_namespace](#input\_gitlab\_agent\_namespace) | Kubernetes namespace to install the GitLab Agent | `string` | `"kube-system"` | no |
| <a name="input_gitlab_agent_replicas"></a> [gitlab\_agent\_replicas](#input\_gitlab\_agent\_replicas) | The number of replicas for the agent | `number` | `1` | no |
| <a name="input_gitlab_agent_token"></a> [gitlab\_agent\_token](#input\_gitlab\_agent\_token) | GitLab Agent token (provided when registering an Agent in GitLab) | `string` | `""` | no |
| <a name="input_gitlab_kas_address"></a> [gitlab\_kas\_address](#input\_gitlab\_kas\_address) | GitLab Agent Server address (provided when registering an Agent in GitLab) | `string` | `"wss://kas.gitlab.com"` | no |
| <a name="input_gke_num_nodes"></a> [gke\_num\_nodes](#input\_gke\_num\_nodes) | Number of GKE nodes | `number` | `2` | no |
| <a name="input_install_gitlab_agent"></a> [install\_gitlab\_agent](#input\_install\_gitlab\_agent) | Install gitlab agent.**IMPORTANT** When you enable this, please make sure to provide the value for `gitlab_agent_token`. | `bool` | `false` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The kubernetes versions of the GKE clusters | `string` | `"1.24."` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | The Google Cloud machine types for each cluster node | `string` | `"e2-standard-4"` | no |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | The GKE release channel to use | `string` | `"stable"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gke-endpoint-url"></a> [gke-endpoint-url](#output\_gke-endpoint-url) | GKE Cluster Endpoint URL |
| <a name="output_kubernetes-cluster-name"></a> [kubernetes-cluster-name](#output\_kubernetes-cluster-name) | GKE Cluster Name |
| <a name="output_project-name"></a> [project-name](#output\_project-name) | Google Cloud Project Name |
| <a name="output_region"></a> [region](#output\_region) | Google Cloud Region where the cluster is provisioned |
| <a name="output_zone"></a> [zone](#output\_zone) | Google Cloud Zone where the cluster is provisioned |

## References

- [Terraform Cloud Variables](https://developer.hashicorp.com/terraform/cloud-docs/api-docs/variables)
- [Terraform Cloud Variable Set](https://developer.hashicorp.com/terraform/cloud-docs/api-docs/variable-sets)
- [Terraform Notifications](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/settings/notifications)

## License

[Apache License](./../LICENSE)

