variable "vpc_id" {}
variable "cluster_name" {
default = "eks_iac_cluster" 
}
variable "public_subnet_1_ids" {}
# variable "public_subnet_2_ids" {}
variable "private_subnet_1_ids" {}
# variable "private_subnet_2_ids" {}
variable "EKS_CLUSTER_ROLE_ARN" {}
variable "environment" {}
variable "project_name" {}

variable "eks_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.29"
}
