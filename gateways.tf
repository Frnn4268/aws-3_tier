# Create Internet Gateway
#----------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.app_name}-igw"
  }
}

# Create NAT Gateway
#----------------------------------------------------

# Create elastic IP
resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  depends_on    = [aws_internet_gateway.igw]
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets["public-subnet-1"].id

  tags = {
    Name = "${var.app_name}-nat"
  }
}
