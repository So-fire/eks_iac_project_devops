data "aws_availability_zones" "azs" {
  state = "available"
}

locals {
additional_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"}
}

###=============================================
# vpc creation
##==============================================

resource "aws_vpc" "eks-cluster-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.environment
  }
}


###=============================================
# Internet gateway creation
##==============================================
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks-cluster-vpc.id

  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
  }
}



###=============================================
#elastic ip creation for natgateway
##==============================================
resource "aws_eip" "eks-ngw-eip" {
domain = "vpc"
depends_on = [aws_internet_gateway.eks_igw]
  
  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
  }
}


###=============================================
# NAT GATEWAY CREATION
##==============================================

resource "aws_nat_gateway" "eks-ngw" {
allocation_id = aws_eip.eks-ngw-eip.id
subnet_id     = aws_subnet.public_subnet_1[0].id

depends_on = [aws_internet_gateway.eks_igw]
  
  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
  }
}


###=====================================================================================
# public routetable creation 
##=======================================================================================
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.eks-cluster-vpc.id

  route {
    cidr_block = var.default_route
    gateway_id = aws_internet_gateway.eks_igw.id
  }

  tags = {
    Name        = "${var.project_name}-public-rt"
    Environment = var.environment
  }
}



###=====================================================================================
# private routetable creation 
##=======================================================================================

resource "aws_route_table"  "private_route_table" {
vpc_id = aws_vpc.eks-cluster-vpc.id

route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks-ngw.id
}
  tags = {
    Name        = "${var.project_name}-private-rt"
    Environment = var.environment
  }
  }



##=====================================================
#  Route Table association for public subnet
##=====================================================
resource "aws_route_table_association" "public_subnet_1_association" {
  count          = 2
  subnet_id      = aws_subnet.public_subnet_1[count.index].id   
  route_table_id = aws_route_table.public_route_table.id
}

# resource "aws_route_table_association" "public_subnet_2_association" {
#   count          = 2
#   subnet_id      = aws_subnet.public_subnet_2[count.index].id
#   route_table_id = aws_route_table.public_route_table.id
# }



##=====================================================
#  Route Table associaion for private subnet
##=====================================================
resource "aws_route_table_association" "private_subnet_1_association" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet_1[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

# resource "aws_route_table_association" "private_subnet_2_association" {
#   count          = 2
#   subnet_id      = aws_subnet.private_subnet_2[count.index].id
#   route_table_id = aws_route_table.private_route_table.id
# }





###=============================================
# public subnet 1 creation
##==============================================

resource "aws_subnet" "public_subnet_1" {
  count                   = 2
  vpc_id                  = aws_vpc.eks-cluster-vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)  
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public_subnet_1-${count.index + 1}"
    Environment = var.environment
  }
}


# ###=============================================
# # public subnet 2 creation
# ##==============================================

# resource "aws_subnet" "public_subnet_2" {
#   count                   = 2
#   vpc_id                  = aws_vpc.eks-cluster-vpc.id
#   cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 10)  
#   availability_zone       = data.aws_availability_zones.azs.names[count.index]
#   map_public_ip_on_launch = true

#   tags = {
#     Name        = "${var.project_name}-public_subnet_2-${count.index + 1}"
#     Environment = var.environment
#   }
# }



resource "aws_subnet" "private_subnet_1" {
  count                   = 2
  vpc_id                  = aws_vpc.eks-cluster-vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 20)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-private_subnet_1-${count.index + 1}"
    Environment = var.environment
  }
}

# resource "aws_subnet" "private_subnet_2" {
#   count                   = 2
#   vpc_id                  = aws_vpc.eks-cluster-vpc.id
#   cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index + 30)
#   availability_zone       = data.aws_availability_zones.azs.names[count.index]
#   map_public_ip_on_launch = true

#   tags = {
#     Name        = "${var.project_name}-private_subnet_2-${count.index + 1}"
#     Environment = var.environment
#   }
# }


 

