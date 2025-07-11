# =================================================================
#  IAM ROLE FOR EKS CLUSTER
# =================================================================

resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.project_name}_EKS_CLUSTER_ROLE"

assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
    {
        Action = [
        "sts:AssumeRole",
        ]
        Effect = "Allow"
        Principal = {
        Service = "eks.amazonaws.com"

        }
    },
    ]
})
}

# =================================================================
#  IAM ROLE FOR EKS NODEGROUP
# =================================================================
resource "aws_iam_role" "eks_nodegroup_role" {
name = "eks_nodegroup_role"

assume_role_policy = jsonencode({
    Statement = [{
    Action = "sts:AssumeRole"
    Effect = "Allow"
    Principal = {
        Service = "ec2.amazonaws.com"
    }
    }]
    Version = "2012-10-17"
})
}



# =================================================================
#  IAM ROLE FOR EKS FARGATE
# =================================================================
resource "aws_iam_role" "eks_fargate_profile_role" {
  name = "eks_fargate_profile_role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

