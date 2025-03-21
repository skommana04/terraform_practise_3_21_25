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
