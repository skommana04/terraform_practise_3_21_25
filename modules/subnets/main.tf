resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnets_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnets_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "saivpc-public-subnet-${count.index}"
    Environment = "Dev"
  }

}

resource "aws_subnet" "private_subnet" {
  count                   = length(var.private_subnets_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.private_subnets_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name        = "saivpc-private-subnet-${count.index}"
    Environment = "Dev"
  }

}

resource "aws_igw" "internet_gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name        = "saivpc-igw"
    Environment = "Dev"
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_igw.internet_gateway.id
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  count          = length(var.public_subnets_cidrs)
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.public_route_table.id

}



