output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.eks-cluster-vpc.id
}

output "public_subnet_1_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public_subnet_1[*].id
}

# output "public_subnet_2_ids" {
#   description = "IDs of private subnets"
#   value       = aws_subnet.public_subnet_2[*].id
# }

output "private_subnet_1_ids" {
  description = "IDs of private subnets"
  value       = aws_subnet.private_subnet_1[*].id
}

# output "private_subnet_2_ids" {
#   description = "IDs of private subnets"
#   value       = aws_subnet.private_subnet_2[*].id
# }

# output "nat_gateway_id" {
#   description = "IDs of NAT Gateways"
#   value       = aws_nat_gateway.main.id
# }