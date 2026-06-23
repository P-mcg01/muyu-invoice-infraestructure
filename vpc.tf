# VPC resources will be defined here when network infrastructure is implemented.
resource "aws_vpc" "muyu" {
  cidr_block = "10.4.0.0/16"
}

# Public subnet resources will be added here for internet-facing components.
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.muyu.id
  cidr_block = "10.4.1.0/24"
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.muyu.id
  cidr_block = "10.4.2.0/24"
}

# Private subnet resources will be added here for internal components.
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.muyu.id
  cidr_block = "10.4.3.0/24"
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.muyu.id
  cidr_block = "10.4.4.0/24"
}

# Internet Gateway resources will be added here for public internet access.
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.muyu.id
}

# Route Tables will be added here for public and private subnet routing.
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.muyu.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.muyu.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
}

# Route Table Associations will be added here to attach subnets to routes.
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.rt_private.id
}
