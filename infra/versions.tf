terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.47.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }

  }

  required_version = ">= 0.14"
}
