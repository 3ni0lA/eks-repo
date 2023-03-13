# EKS IAM Role
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

# Enabling IAM Role For Service Accounts

data "tls_certificate" "ekstls" {
  url = data.aws_eks_cluster.first-eks.identity[0].oidc[0].issuer
}
resource "aws_iam_openid_connect_provider" "eksopidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.ekstls.certificates[*].sha1_fingerprint
  url             = data.tls_certificate.ekstls.url
}




data "aws_iam_policy_document" "eksdoc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eksopidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eksopidc.arn]
      type        = "Federated"
    }
  }
}


# Eks Definition

resource "aws_eks_cluster" "first-eks" {
  name     = "${var.cluster_name}"
  role_arn = aws_iam_role.first-eksrole.arn

  vpc_config {
    subnet_ids = [module.vpc.private_subnets[0]]
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














