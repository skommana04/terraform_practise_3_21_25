resource "aws_db_subnet_group" "subnet_group" {
  name       = "sai-subnet-group"
  subnet_ids = module.vpc.private_subnet_ids

}

resource "aws_db_instance" "rds_instance" {
  instance_class         = "db.m5d.large"
  allocated_storage      = 20
  engine                 = "mysql"
  storage_type           = "gp2"
  engine_version         = "8.0.40"
  username               = "petclinic"
  password               = "petclinic"
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  identifier             = "petclinic"
  vpc_security_group_ids = [var.db_sg.id]

  publicly_accessible = true
  skip_final_snapshot = true

  tags = {
    Name = "sai-rds"
  }
}



