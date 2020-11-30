variable "cluster_name" {
    type = string
    description = "name of the cluster"

    validation {
        condition = length(var.cluster_name) > 4
        error_message = "The cluster name needs to larger than 4 letters."
    }
}

variable "tag_account" {
    type = string
    description = "department"
}

variable "tag_creator" {
    type = string
    description = "creator"
}

variable "run_date" {
    type = string
    description = "date when script was run"
}

variable "region" {
  default     = "eu-central-1"
  type        = string
  description = "Region of the VPC"
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "subnet_cidr_blocks" {
  default     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  type        = list
  description = "List of public subnet CIDR blocks"
}

variable "availability_zones" {
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  type        = list
  description = "List of availability zones"
}

variable "public" {
  default     = false
  type        = bool
  description = "Are subnets public?"
}