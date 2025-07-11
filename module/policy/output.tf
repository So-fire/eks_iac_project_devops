output "worker_node_policy_attachment_id" {
  value = aws_iam_role_policy_attachment.eks-nodegroup-WorkerNodePolicy_attachment.id
}
output "amazoneks_cni_policy_attachment_id" {
  value = aws_iam_role_policy_attachment.eks-nodegroup-AmazonEKS_CNI_Policy_attachment.id
}
output "container_registry_readonly_policy_attacment_id" {
  value = aws_iam_role_policy_attachment.eks-demo-ng-ContainerRegistryReadOnly_policy_attachment.id
}




