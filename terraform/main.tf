
provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "renovate-eks-lab-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "renovate-eks-lab-igw"
  }
}

resource "aws_subnet" "public" {
  count = 2

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 1)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name                     = "renovate-eks-lab-public-${count.index + 1}"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "renovate-eks-lab-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count = 2

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}



# resource "aws_eks_cluster" "main" {
#   name     = var.cluster_name
#   role_arn = aws_iam_role.eks_cluster.arn
#   version  = var.kubernetes_version

#   access_config {
#     authentication_mode = "API"
#   }

#   vpc_config {
#     subnet_ids = var.subnet_ids
#   }

#   depends_on = [
#     aws_iam_role_policy_attachment.eks_cluster
#   ]
# }


# # # retrieves the cluster's Kubernetes version, which is useful for compatibility validation.
# # data "aws_eks_cluster" "existing" {
# #   name = "my-eks-cluster"
# # }

