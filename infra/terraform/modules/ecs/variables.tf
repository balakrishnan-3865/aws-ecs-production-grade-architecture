variable "cluster_name" {}

variable "service_name" {}

variable "private_subnets" {
  type = list(string)
}

variable "vpc_id" {}

variable "target_group_arn" {}