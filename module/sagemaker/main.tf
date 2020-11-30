data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_iam_role" "sagemaker_role" {
  name               = format("%s-sagemaker-role", var.cluster_name)
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.sagemaker_policy_document.json
}

data "aws_iam_policy_document" "sagemaker_policy_document_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "sagemaker_policy" {
  name        = format("%s-sagemaker-policy", var.cluster_name)
  description = "Allow Sagemaker to create model"
  policy      = data.aws_iam_policy_document.sagemaker_policy_document.json
}

data "aws_iam_policy_document" "sagemaker_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:*"
    ]
    resources = [
      "*"
    ]
  }
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
