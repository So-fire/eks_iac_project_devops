variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}
variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "eks"
}
variable "default_route" {
  description = "default"
  type        = string
  default     = "0.0.0.0/0"
}


variable "cluster_name" {
type = string
default = "eks-cluster"
description = "value of the EKS cluster name"
  
}