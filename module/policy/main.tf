resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
role       = var.EKS_CLUSTER_ROLE_NAME
}




resource "aws_iam_role_policy_attachment" "eks-nodegroup-WorkerNodePolicy_attachment" {
policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
role       = var.EKS_CLUSTER_NODEGROUP_NAME

}

resource "aws_iam_role_policy_attachment" "eks-nodegroup-AmazonEKS_CNI_Policy_attachment" {
policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
role       = var.EKS_CLUSTER_NODEGROUP_NAME
}

resource "aws_iam_role_policy_attachment" "eks-demo-ng-ContainerRegistryReadOnly_policy_attachment" {
policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
role       = var.EKS_CLUSTER_NODEGROUP_NAME
}


resource "aws_iam_role_policy_attachment" "fargate-execution-policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = var.EKS_FARGATE_ROLE_NAME
}