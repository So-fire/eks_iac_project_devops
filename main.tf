terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.44.0" # 👈 this is a known good version for EKS module 20+
    }
  }

  required_version = ">= 1.5.0"
}

module "roles" {
  source            = "./module/roles"

  project_name     = var.project_name

}

module "policy" {

  source                       = "./module/policy"
  
  EKS_CLUSTER_ROLE_NAME        = module.roles.EKS_CLUSTER_ROLE_NAME
  EKS_CLUSTER_NODEGROUP_NAME   = module.roles.EKS_CLUSTER_NODEGROUP_NAME   
  EKS_FARGATE_ROLE_NAME        = module.roles.EKS_FARGATE_ROLE_NAME 
}

# module "security_group" {
#   source                  = "./module/securitygroup"
#   vpc_id                  = module.vpc.vpc_id
# }


module "vpc" {
  source = "./module/vpc"

  default_route = var.default_route
  project_name  = var.project_name
  vpc_cidr      = var.vpc_cidr
  environment   = var.environment
  cluster_name  = var.cluster_name 
}


module "eks" {
  source = "./module/eks"
environment                   = var.environment 
project_name                  = var.project_name 
eks_version                   = var.eks_version
vpc_id                        = module.vpc.vpc_id
cluster_name                  = var.cluster_name
public_subnet_1_ids                  = module.vpc.public_subnet_1_ids
# public_subnet_2_ids                  = module.vpc.public_subnet_2_ids
private_subnet_1_ids                 = module.vpc.private_subnet_1_ids
# private_subnet_2_ids                 = module.vpc.private_subnet_2_ids 
EKS_CLUSTER_ROLE_ARN                 = module.roles.EKS_CLUSTER_ROLE_ARN 
# This ensures the IAM role and attachment are created before the EKS cluster
  depends_on = [module.roles]
}

module "nodegroup" {
  source                              = "./module/nodegroup"
  cluster_name                        = module.eks.cluster_name
  EKS_NODEGROUP_ROLE_ARN              = module.roles.EKS_NODEGROUP_ROLE_ARN
  private_subnet_1_ids                = module.vpc.private_subnet_1_ids
  # private_subnet_2_ids                = module.vpc.private_subnet_2_ids
  worker_node_policy_attachment_id    = module.policy.worker_node_policy_attachment_id
  amazoneks_cni_policy_attachment_id  = module.policy.amazoneks_cni_policy_attachment_id
  container_registry_readonly_policy_attacment_id = module.policy.container_registry_readonly_policy_attacment_id
# This ensures the IAM role and attachment are created before the EKS nodegroup
  depends_on = [module.fargate]
}

module "fargate" {
  source                              = "./module/fargate"
  cluster_name                        = module.eks.cluster_name
  private_subnet_1_ids                = module.vpc.private_subnet_1_ids
  # private_subnet_2_ids                = module.vpc.private_subnet_2_ids
  EKS_FARGATE_ROLE_ARN                = module.roles.EKS_FARGATE_ROLE_ARN

  depends_on = [module.roles]
}
