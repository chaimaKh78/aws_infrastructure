resource "aws_vpc" "myvpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "production-vpc"
  }
}

# Subnets
resource "aws_subnet" "subnets" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.type == "public" ? true : false

  tags = {
    Name        = each.key
    Type        = each.value.type
    Environment = "production"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "production-igw"
  }
}

# Elastic IP pour NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    Name = "nat-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnets["public-1"].id

  tags = {
    Name = "nat-gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Route Table - Public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Route Table - Private
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "private-rt"
  }
}

# Association des subnets publics à la route table publique
resource "aws_route_table_association" "public_assoc" {
  for_each = {
    for k, v in aws_subnet.subnets : k => v if v.tags["Type"] == "public"
  }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Association des subnets privés à la route table privée
resource "aws_route_table_association" "private_assoc" {
  for_each = {
    for k, v in aws_subnet.subnets : k => v if v.tags["Type"] == "private"
  }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

