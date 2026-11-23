terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "renovate-eks-tfstate-143898400191"
    key          = "eks-lab/terraform.tfstate"
    region       = "eu-west-1"
    encrypt      = true
    use_lockfile = true # enables S3-native state locking, preventing two Terraform operations from modifying the same state simultaneously.
  }
}


# provider "aws" {
#   region = var.aws_region
# }

