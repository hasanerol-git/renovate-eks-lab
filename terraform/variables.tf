variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"
}

# Kubernetes version is only for terraform. for renovate, you need to check all the files that renovate will scan.
variable "kubernetes_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.34"
}

variable "aws_region" {
  description = "AWS region for the EKS cluster"
  type        = string
  default     = "eu-west-1"
}