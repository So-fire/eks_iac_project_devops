# =================================================================
#  IAM OUTPUT FOR EKS CLUSTER ROLE
# =================================================================
output "EKS_CLUSTER_ROLE_ARN" {
  value = aws_iam_role.eks_cluster_role.arn
}
output "EKS_CLUSTER_ROLE_NAME" {
  value = aws_iam_role.eks_cluster_role.name
}

# =================================================================
#  IAM OUTPUT FOR EKS NODEGROUP ROLE
# =================================================================
output "EKS_NODEGROUP_ROLE_ARN" {
  value = aws_iam_role.eks_nodegroup_role.arn
}
output "EKS_CLUSTER_NODEGROUP_NAME" {
  value = aws_iam_role.eks_nodegroup_role.name
}


# =================================================================
#  IAM OUTPUT FOR EKS FARGATE ROLE
# =================================================================
output "EKS_FARGATE_ROLE_ARN" {
  value = aws_iam_role.eks_fargate_profile_role.arn
}
output "EKS_FARGATE_ROLE_NAME" {
  value = aws_iam_role.eks_fargate_profile_role.name
}