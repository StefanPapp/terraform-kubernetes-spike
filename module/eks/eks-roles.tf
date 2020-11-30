
resource "aws_iam_role" "eks" {
  name               = format("%s-eks-role", var.cluster_name)
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks-attach-eks-cluster-policy" {
  role       = aws_iam_role.eks.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks-attach-service-policy" {
  role       = aws_iam_role.eks.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_policy" "eks_permissions" {
  name        = "EksPermissions"
  description = "EksPermissions"
  policy      = data.aws_iam_policy_document.eks_permissions.json
}

data "aws_iam_policy_document" "eks_permissions" {

  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeInternetGateways",
      "ec2:DescribeAccountAttributes"
    ]
    resources = [
    "*"]
  }
}

resource "aws_iam_role_policy_attachment" "eks-attach-eks-permmission-policy" {
  role       = aws_iam_role.eks.name
  policy_arn = aws_iam_policy.eks_permissions.arn
}

# Node Role

resource "aws_iam_role" "eks_node_role" {
  name               = format("%s-node-role", var.cluster_name)
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_node_role.json
}



data "aws_iam_policy_document" "assume_node_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "autoscaler_policy" {
  name        = "AutoScalerPolicy"
  description = "Autoscaler Poloic"
  policy      = data.aws_iam_policy_document.autoscaler_policy_document.json
}

data "aws_iam_policy_document" "autoscaler_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup"
    ]
    resources = [
    "*"]
  }
}

resource "aws_iam_role_policy_attachment" "autoscaler" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = aws_iam_policy.autoscaler_policy.arn
}
#TODO

resource "aws_iam_role_policy_attachment" "eks-attach-eks-cni-policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
resource "aws_iam_role_policy_attachment" "eks-attach-eks-worker-policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
resource "aws_iam_role_policy_attachment" "eks-attach-eks-registry-policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
