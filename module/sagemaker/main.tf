resource "aws_iam_role" "sagemaker_role" {
  name               = format("%s-sagemaker-role", var.cluster_name)
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.policy_assume.json
}

data "aws_iam_policy_document" "policy_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}


resource "aws_iam_policy" "sagemaker_permissions_policy" {
  name        = "sagemaker_permissions"
  description = "sagemaker_permissions"
  policy      = data.aws_iam_policy_document.sagemaker_permissions_document.json
}

data "aws_iam_policy_document" "sagemaker_permissions_document" {

  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListAllMyBuckets",
      "s3:GetObjectTagging",
      "s3:PutObjectTagging",
      "iam:PassRole",
      "ecr:DescribeRepositories"
    ]
    resources = [
    "*"]
  }
}

