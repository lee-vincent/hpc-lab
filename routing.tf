# Elastic IP for NAT Gateway
# resource "aws_eip" "nat" {
#   domain = "vpc"

#   tags = {
#     Name = "hpc-lab-nat-eip"
#   }

#   depends_on = [aws_internet_gateway.hpc_lab]
# }

# NAT Gateway
# resource "aws_nat_gateway" "hpc_lab" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public.id

#   tags = {
#     Name = "hpc-lab-nat-gw"
#   }

#   depends_on = [aws_internet_gateway.hpc_lab]
# }

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.hpc_lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hpc_lab.id
  }

  tags = {
    Name = "hpc-lab-public-rt"
  }
}

# Private Route Table
# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.hpc_lab.id

#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.hpc_lab.id
#   }

#   tags = {
#     Name = "hpc-lab-private-rt"
#   }
# }

# Route Table Associations
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# resource "aws_route_table_association" "private" {
#   subnet_id      = aws_subnet.private.id
#   route_table_id = aws_route_table.private.id
# }