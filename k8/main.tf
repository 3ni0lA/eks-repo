terraform {
  required_version =  ">= 0.12.1"
}
provider "aws" {
  region  = var.region
}

terraform {
  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.0"
    }

     route53 = {
      source = "winebarrel/route53"
      version = "0.1.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
  }
}
}
provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

provider "route53" {
  aws_region = "eu-west-2"
}

# data "aws_eks_cluster" "first-eks" {
#   name = var.cluster_name
# }
# data "aws_eks_cluster_auth" "first-eks_auth" {
#   name = var.cluster_name
# }
# provider "kubernetes" {
#   config_path = "~/.kube/config"
#   host                   = data.aws_eks_cluster.first-eks.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.first-eks.certificate_authority[0].data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
#     command     = "aws"
#   }
# }

