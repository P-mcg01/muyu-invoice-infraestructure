resource "aws_vpc" "this" {
  cidr_block = var.cidr
}

resource "aws_subnet" "public" {
  for_each = { for index, cidr in var.public_subnets : index => cidr }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = var.azs[each.key]
}

resource "aws_subnet" "private" {

  for_each = { for index, cidr in var.private_subnets : index => cidr }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = var.azs[each.key]
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? 1 : 0

  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
  count = var.enable_nat_gateway ? 1 : 0

  allocation_id = aws_eip.nat[0].id
  subnet_id     = values(aws_subnet.public)[0].id

  depends_on = [
    aws_internet_gateway.this
  ]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
}

resource "aws_route_table" "private" {
  count  = var.enable_nat_gateway ? 1 : 0
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[0].id
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[0].id
}
