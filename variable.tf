variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
default = "my-cluster" 
}

variable "ENV" {
  type    = string
  default = "dev"
}


variable "environment" {
  description = "Environment name"
  type        =  string
  default     =  "Dev"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "eks_iac_project"
}

variable "default_route" {
  description = "default"
  type        = string
  default     = "0.0.0.0/0"
}

variable "eks_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.29"
}
###=============================================
#  VPC CIDR BLOCK VARIABLES
###============================================
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# ###=============================================
# #  ROUTE VARIABLES
# ###============================================
# variable "default_route" {
#   description = "Default route for route tables"
#   type        = string
#   default     = "0.0.0.0/0"
# }
