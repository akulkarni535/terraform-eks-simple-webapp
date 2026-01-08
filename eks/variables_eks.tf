
variable "name" {
    type = string
}

variable "eks_arn" {
    type = string
}


variable "ec2_arn" {
    type = string
}

variable "min_size" {
    type = number
}

variable "max_size" {
    type = number
}



variable "desired_size" {
    type = number
}

variable "instance_type" {
    type = list(string)
}

variable "eks_cluster_policy_attachment_id" {type = string}
variable "ec2_rpa_ecr_id" {type = string}
variable "ecr_policy" {type = string}
variable "cni_policy" {type = string}