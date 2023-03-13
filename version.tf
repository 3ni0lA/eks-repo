terraform {
  required_version =  ">= 0.12.1"
}
provider "aws" {
  region  = var.region
}
# provider "tls" {
# proxy {
#     url = "https://corporate.proxy.service"
#   }
# }

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = ">= 4.47"
#     }

