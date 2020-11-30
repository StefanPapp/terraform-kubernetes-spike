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