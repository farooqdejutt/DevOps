provider "aws" {

  region="eu-central-1"
  profile = "default"

}
terraform {

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.14.0"
    }
  }

  required_version = "~> 1.0"
}