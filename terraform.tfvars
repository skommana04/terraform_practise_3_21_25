cidr                 = "10.0.0.0/16"
public_subnets_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

private_subnets_cidrs = ["10.0.101.0/24", "10.0.201.0/24"]
ami_id                = "ami-084568db4383264d4"
key_name              = "mern-sai"
instance_type         = "t2.medium"
