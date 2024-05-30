# deploy subnets
#----------------------------------------------------
# deploy the public subnets
resource "aws_subnet" "public_subnets" {
  for_each          = var.public_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value + 100)
  availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]

  map_public_ip_on_launch = var.auto_ipv4

  tags = {
    Name   = "${var.app_name}-${each.key}"
    Subnet = "Public"

  }
}

# deploy the private subnets
resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value + 1)
  availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]

  tags = {
    Name   = "${var.app_name}-${each.key}"
    Subnet = "Private"
  }
}
