resource "aws_eks_fargate_profile" "eks_fargate_profile" { 
cluster_name           = var.cluster_name
fargate_profile_name   = "eks_fargate_profile_1"
pod_execution_role_arn = var.EKS_FARGATE_ROLE_ARN
selector {
    namespace = "kube-system"
    #can further filter by labels
}
selector {
    namespace = "default"
}
#these subnets must be labeled with kubernetes.io/cluster/{cluster-name} = owned
subnet_ids      = flatten([
        var.private_subnet_1_ids,
        # var.private_subnet_2_ids
    ])

# depends_on = [ aws_iam_role_policy_attachment.fargate-execution-policy ]

}