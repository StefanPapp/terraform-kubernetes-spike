* Modules
* Spot Instances
* Hashicorp Vault
* Git
* aws eks --region $REGION update-kubeconfig --name $CLUSTER_NAME
* aws ec2 --region $REGION import-key-pair --key-name "$KEY_NAME" --public-key-material file://./${KEY_NAME}.pub



Error: Reference to undeclared resource

  on module/eks/main.tf line 3, in resource "aws_eks_cluster" "splice-infra":
   3:   role_arn = aws_iam_role.example.arn

A managed resource "aws_iam_role" "example" has not been declared in
module.Eks.


Error: Reference to undeclared resource

  on module/eks/main.tf line 15, in resource "aws_eks_cluster" "splice-infra":
  15:     aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,

A managed resource "aws_iam_role_policy_attachment"
"example-AmazonEKSClusterPolicy" has not been declared in module.Eks.


Error: Reference to undeclared resource

  on module/eks/main.tf line 32, in resource "aws_eks_node_group" "core":
  32:   cluster_name    = aws_eks_cluster.example.name

A managed resource "aws_eks_cluster" "example" has not been declared in
module.Eks.


Error: Reference to undeclared resource

  on module/eks/main.tf line 34, in resource "aws_eks_node_group" "core":
  34:   node_role_arn   = aws_iam_role.example.arn

A managed resource "aws_iam_role" "example" has not been declared in
module.Eks.


Error: Reference to undeclared resource

  on module/eks/main.tf line 35, in resource "aws_eks_node_group" "core":
  35:   subnet_ids      = aws_subnet.example[*].id

A managed resource "aws_subnet" "example" has not been declared in module.Eks.


Error: Invalid reference

  on module/eks/main.tf line 38, in resource "aws_eks_node_group" "core":
  38:      components = core

A reference to a resource type must be followed by at least one attribute
access, specifying the resource name.


Error: Reference to undeclared resource

  on module/eks/main.tf line 63, in resource "aws_eks_node_group" "core":
  63:     aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,

A managed resource "aws_iam_role_policy_attachment"
"example-AmazonEKSWorkerNodePolicy" has not been declared in module.Eks.


Error: Reference to undeclared resource

  on module/eks/main.tf line 70, in resource "aws_eks_node_group" "db":
  70:   cluster_name    = aws_eks_cluster.example.name

A managed resource "aws_eks_cluster" "example" has not been declared in
module.Eks.


Error: Reference to undeclared resource

  on module/eks/main.tf line 72, in resource "aws_eks_node_group" "db":
  72:   node_role_arn   = aws_iam_role.example.arn

A managed resource "aws_iam_role" "example" has not been declared in
module.Eks.


Error: Reference to undeclared resource

  on module/eks/main.tf line 73, in resource "aws_eks_node_group" "db":
  73:   subnet_ids      = aws_subnet.example[*].id

A managed resource "aws_subnet" "example" has not been declared in module.Eks.


Error: Invalid reference

  on module/eks/main.tf line 76, in resource "aws_eks_node_group" "db":
  76:      components = db

A reference to a resource type must be followed by at least one attribute
access, specifying the resource name.


Error: Reference to undeclared resource

  on module/eks/main.tf line 101, in resource "aws_eks_node_group" "db":
 101:     aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,

A managed resource "aws_iam_role_policy_attachment"
"example-AmazonEKSWorkerNodePolicy" has not been declared in module.Eks.


Error: Reference to undeclared resource

  on module/eks/main.tf line 108, in resource "aws_eks_node_group" "meta":
 108:   cluster_name    = aws_eks_cluster.example.name

A managed resource "aws_eks_cluster" "example" has not been declared in
module.Eks.


Error: Reference to undeclared resource

  on module/eks/main.tf line 110, in resource "aws_eks_node_group" "meta":
 110:   node_role_arn   = aws_iam_role.example.arn

A managed resource "aws_iam_role" "example" has not been declared in
module.Eks.


Error: Reference to undeclared resource

  on module/eks/main.tf line 111, in resource "aws_eks_node_group" "meta":
 111:   subnet_ids      = aws_subnet.example[*].id

A managed resource "aws_subnet" "example" has not been declared in module.Eks.


Error: Invalid reference

  on module/eks/main.tf line 114, in resource "aws_eks_node_group" "meta":
 114:      components = meta

A reference to a resource type must be followed by at least one attribute
access, specifying the resource name.


Error: Reference to undeclared resource

  on module/eks/main.tf line 139, in resource "aws_eks_node_group" "meta":
 139:     aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,

A managed resource "aws_iam_role_policy_attachment"
"example-AmazonEKSWorkerNodePolicy" has not been declared in module.Eks.


Error: Reference to undeclared resource

  on module/sagemaker/main.tf line 8, in resource "aws_iam_role" "sagemaker_role":
   8:   assume_role_policy = data.aws_iam_policy_document.assume_role.json

A data resource "aws_iam_policy_document" "assume_role" has not been declared
in module.Sagemaker.

❯ terraform plan

Error: Duplicate data "aws_iam_policy_document" configuration

  on module/sagemaker/main.tf line 27:
  27: data "aws_iam_policy_document" "sagemaker_policy_document" {

A aws_iam_policy_document data resource named "sagemaker_policy_document" was
already declared at module/sagemaker/main.tf:11,1-59. Resource names must be
unique per type in each module.