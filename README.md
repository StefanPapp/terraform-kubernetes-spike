# terraform-kubernetes-spike

This is just a spike to build up a kubernetes cluster in AWS. I just used it to explore how it works.

There are some known issues to consider (see known issues)

## To get it running
The easiest way is to create terraform.tfvars file in your route directory


cluster_name = cluster name
tag_account = department who created it
tag_creator = you created the cluster
region = aws region
cidr_block =
public = true if public (private clusters need to be checked
access_key = amazon key
secret_key = Amazon secret key

We have an empty template file terraform.tfvars.template. This can be renamed to terraform.tfvars and the parameters can be added there.

Also use your own bucket in the main.tf line4