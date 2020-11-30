resource "aws_eks_cluster" "splice_infra" {
  name     = "splice-infra"
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    subnet_ids              = [var.subnet_cidr_blocks[0], var.subnet_cidr_blocks[1]]
    endpoint_private_access = true
    endpoint_public_access  = true
  }
  version = var.kubernetes_version

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks-attach-eks-cluster-policy,
    aws_iam_role_policy_attachment.eks-attach-service-policy,
  ]

  # --role-arn $EKS_ROLE --resources-vpc-config \
  #         ,publicAccessCidrs=$REMOTE_ACCESS_CIDR \
}

output "endpoint" {
  value = aws_eks_cluster.splice_infra.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.splice_infra.certificate_authority[0].data
}

resource "aws_eks_node_group" "core" {
  cluster_name    = aws_eks_cluster.splice_infra.name
  node_group_name = format("%s-core", var.cluster_name)
  node_role_arn   = aws_iam_role.eks_node_role.arn
  # subnet_ids      = aws_subnet.example[*].id
  subnet_ids = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  # multple_az
  labels = {
    components = "core"
  }
  disk_size      = 100
  instance_types = var.instance_type
  # --node-role $NODE_ROLE

  tags = {
    Name         = format("%s-core", var.cluster_name)
    Purpose      = format("%s-k8s", var.cluster_name)
    Department   = format("%s", var.tag_account)
    Creator      = format("%s", var.tag_creator)
    Date_Created = format("%s", var.run_date)
  }
  scaling_config {
    desired_size = var.core_node_desired
    max_size     = var.core_node_max
    min_size     = var.core_node_min
  }
  remote_access {
    ec2_ssh_key = var.key_name
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-attach-eks-registry-policy,
    aws_iam_role_policy_attachment.eks-attach-eks-worker-policy,
    aws_iam_role_policy_attachment.eks-attach-eks-cni-policy,
  ]
}

resource "aws_eks_node_group" "db" {
  cluster_name    = aws_eks_cluster.splice_infra.name
  node_group_name = format("%s-db", var.cluster_name)
  node_role_arn   =  aws_iam_role.eks_node_role.arn
  # subnet_ids      = aws_subnet.example[*].id
  subnet_ids = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  labels = {
    components = "db"
  }
  disk_size      = 100
  instance_types = var.instance_type
  # --node-role $NODE_ROLE

  tags = {
    Name         = format("%s-core", var.cluster_name)
    Purpose      = format("%s-k8s", var.cluster_name)
    Department   = format("%s", var.tag_account)
    Creator      = format("%s", var.tag_creator)
    Date_Created = format("%s", var.run_date)
  }
  scaling_config {
    desired_size = var.core_node_desired
    max_size     = var.core_node_max
    min_size     = var.core_node_min
  }
  remote_access {
    ec2_ssh_key = var.key_name
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-attach-eks-registry-policy,
    aws_iam_role_policy_attachment.eks-attach-eks-worker-policy,
    aws_iam_role_policy_attachment.eks-attach-eks-cni-policy,
  ]
}

resource "aws_eks_node_group" "meta" {
  cluster_name    = aws_eks_cluster.splice_infra.name
  node_group_name = format("%s-meta", var.cluster_name)
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      =  ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  # multple_az
  labels = {
    components = "meta"
  }
  disk_size      = 100
  instance_types = var.instance_type
  # --node-role $NODE_ROLE

  tags = {
    Name         = format("%s-meta", var.cluster_name)
    Purpose      = format("%s-k8s", var.cluster_name)
    Department   = format("%s", var.tag_account)
    Creator      = format("%s", var.tag_creator)
    Date_Created = format("%s", var.run_date)
  }
  scaling_config {
    desired_size = var.core_node_desired
    max_size     = var.core_node_max
    min_size     = var.core_node_min
  }
  remote_access {
    ec2_ssh_key = var.key_name
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-attach-eks-registry-policy,
    aws_iam_role_policy_attachment.eks-attach-eks-worker-policy,
    aws_iam_role_policy_attachment.eks-attach-eks-cni-policy,
  ]
}
