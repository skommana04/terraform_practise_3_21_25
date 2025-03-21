provider "aws" {
  region = "us-east-1"

}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "saibucket0123456789"

  tags = {
    Name        = "saibucket0123456789"
    Environment = "Dev"
  }
}

terraform {
  backend "s3" {}
}


module "my_vpc" {
  source = "./modules/vpc"
  cidr   = var.cidr
}

module "my_public_subnets" {
  source               = "./modules/subnets"
  vpc_id               = module.my_vpc.vpc_id
  public_subnets_cidrs = var.public_subnets_cidrs
  availability_zones   = var.availability_zones

}
