resource "aws_eks_cluster" "eks_cluster" {
    name = var.cluster_name
    role_arn = var.EKS_CLUSTER_ROLE_ARN
    
    vpc_config {
    endpoint_private_access = true      //this means that my worker node will join the cluster interally within the vpc andthey wont get routed out of the vpc
    endpoint_public_access = true       //this means that i want my cluster to be accessed outside the vpc
    subnet_ids = flatten([
        var.public_subnet_1_ids,
        #var.public_subnet_2_ids,
        var.private_subnet_1_ids,
       # var.
       
        # aws_subnet.private_subnet_1.id,
        # aws_subnet.private_subnet_2.id,
        # aws_subnet.public_subnet_1.id,
        # aws_subnet.public_subnet_2.id
    ])
    }
    access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true
    }
    # bootstrap_self_managed_addons = true
    
    tags = {
    Name        = "${var.project_name}-eks_cluster"
    Environment = var.environment
    }
    version = var.eks_version

    # upgrade_policy {
    # support_type = "STANDARD"
    # }
}


