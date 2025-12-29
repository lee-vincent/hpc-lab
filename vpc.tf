# VPC
resource "aws_vpc" "hpc_lab" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "hpc-lab-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "hpc_lab" {
  vpc_id = aws_vpc.hpc_lab.id

  tags = {
    Name = "hpc-lab-igw"
  }
}