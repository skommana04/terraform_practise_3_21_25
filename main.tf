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
  source                = "./modules/subnets"
  vpc_id                = module.my_vpc.vpc_id
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  availability_zones    = var.availability_zones

}


module "my_security_group" {
  source = "./modules/sg"
  vpc_id = module.my_vpc.vpc_id
}

module "my_rds" {
  source             = "./modules/rds"
  private_subnet_ids = module.my_public_subnets.private_subnet_ids
  db_sg_id           = module.my_security_group.db_sg_id
}

module "my_alb" {
  source            = "./modules/alb"
  vpc_id            = module.my_vpc.vpc_id
  public_subnet_ids = module.my_public_subnets.public_subnet_ids
  lb_sg_id          = module.my_security_group.lb_sg_id
}

module "my_autoscaling_group" {
  source        = "./modules/autoscaling"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  #availability_zones = var.availability_zones
  private_subnet_ids = module.my_public_subnets.private_subnet_ids
  security_groups    = [module.my_security_group.ec2_sg_id]
  rds_db_endpoint    = module.my_rds.rds_db_endpoint
  target_group_arns  = module.my_alb.alb_tg_arn
}

# module "my_ec2_instance" {
#   source          = "./modules/ec2"
#   ami_id          = var.ami_id
#   instance_type   = var.instance_type
#   key_name        = var.key_name
#   subnet_id       = element(module.my_public_subnets.private_subnet_ids, 0)
#   security_groups = module.my_security_group.ec2_sg_id
# }

