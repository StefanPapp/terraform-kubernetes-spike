
variable "kubernetes_version" {
    type = string
    description = "kubernetes_version"
    default = "1.17"
}

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

variable "instance_type" {
    type = list
    description = "Instance Type"
    default = ["t2.micro"]
}

variable "key_name" {
    type = string
    default = "changeme"
}

variable "run_date" {
    type = string
    description = "date when script was run"
}


variable "subnet_cidr_blocks" {
  default     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  type        = list
  description = "List of public subnet CIDR blocks"
}

variable "core_node_desired" {
    type = number
    description = "date when script was run"
    default = 1
}

variable "core_node_max" {
    type = number
    description = "dorenodemax"
    default = 1
}

variable "core_node_min" {
    type = number
    description = "corenode min"
    default = 1
}
