resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name        = "my-ec2-instance"
    Environment = "Dev"
  }

}




