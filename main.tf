terraform {
  required_version = ">= 0.13"
  backend "s3" {
    bucket  = "terraform-stefanpapp"
    key     = "terraform.tfstate"
    encrypt = true
    region  = "eu-central-1"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-lock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

provider "aws" {
  region = var.region
}

module "s3" {
  source       = "./module/s3"
  cluster_name = var.cluster_name
  tag_account  = var.tag_account
  tag_creator  = var.tag_creator
  run_date     = timestamp()
}
module "Sagemaker" {
  source       = "./module/sagemaker"
  cluster_name = var.cluster_name
  tag_account  = var.tag_account
  tag_creator  = var.tag_creator
  run_date     = timestamp()
}
module "Eks" {
  source             = "./module/eks"
  cluster_name       = var.cluster_name
  tag_account        = var.tag_account
  tag_creator        = var.tag_creator
  run_date           = timestamp()
  subnet_cidr_blocks = var.subnet_cidr_blocks
}
