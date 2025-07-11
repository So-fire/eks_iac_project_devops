resource "aws_eks_node_group" "eks-demo-node-group" {
cluster_name    = var.cluster_name
node_role_arn   = var.EKS_NODEGROUP_ROLE_ARN
node_group_name = "demo-eks-node-group"
subnet_ids      = flatten([
        var.private_subnet_1_ids,
        # var.private_subnet_2_ids
    ])
scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
}
update_config {
    max_unavailable = 1
    
}
# instance_types = ["t3.small"]

# # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
# # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
 depends_on = [
        var.worker_node_policy_attachment_id,
        var.amazoneks_cni_policy_attachment_id,
        var.container_registry_readonly_policy_attacment_id
#      aws_iam_role_policy_attachment.eks-nodegroup-WorkerNodePolicy_attachment,
#      aws_iam_role_policy_attachment.eks-nodegroup-AmazonEKS_CNI_Policy_attachment,
#      aws_iam_role_policy_attachment.eks-demo-ng-ContainerRegistryReadOnly_policy_attachment,
 ]
}
