terraform {
  backend "s3" {
    encrypt = true
    bucket  = "eks-bucket3876"
    key     = "backend.tf"
    region  = "us-east-1"
    dynamodb_table = "eks_tablelock"
  }
}