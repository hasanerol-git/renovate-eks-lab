
# AWS-managed VPC CNI
resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "vpc-cni"

  # renovate: eksAddonsFilter={"kubernetesVersion":"1.34","addonName":"vpc-cni","region":"eu-west-1"}
  addon_version = "v1.23.2-eksbuild.12"

  depends_on = [
    aws_eks_cluster.main
  ]
}

# AWS-managed kube-proxy
resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "kube-proxy"

  # renovate: eksAddonsFilter={"kubernetesVersion":"1.34","addonName":"kube-proxy","region":"eu-west-1"}
  addon_version = "v1.34.6-eksbuild.64"

  depends_on = [
    aws_eks_cluster.main
  ]
}

# AWS-managed CoreDNS
resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "coredns"

  # renovate: eksAddonsFilter={"kubernetesVersion":"1.34","addonName":"coredns","region":"eu-west-1"}
  addon_version = "v1.13.2-eksbuild.68"

  depends_on = [
    aws_eks_node_group.main
  ]
}
