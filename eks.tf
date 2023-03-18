# EKS IAM Role
 EKS IAM Role
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "first-eksrole" {
  name               = "first-eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "first-eksrole-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.first-eksrole.name
}


resource "aws_iam_role_policy_attachment" "first-eksrole-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.first-eksrole.name
}



# Eks Definition

resource "aws_eks_cluster" "first-eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.first-eksrole.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private-eu-west-2a.id,
      aws_subnet.private-eu-west-2b.id,
      aws_subnet.public-eu-west-2a.id,
      aws_subnet.public-eu-west-2b.id


    ]
  }



  depends_on = [
    aws_iam_role_policy_attachment.first-eksrole-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.first-eksrole-AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.first-eks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.first-eks.certificate_authority
}

output "region" {
  description = "AWS region"
  value       = var.region
}






