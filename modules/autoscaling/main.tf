resource "aws_launch_template" "launchtemp" {
  name_prefix            = "saiLaunchTemplate"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_groups
  user_data              = base64encode(templatefile(("user_data.sh"), { mysql_url = var.rds_db_endpoint }))

  tags = {
    key   = "sai-app"
    value = "true"
  }

}

resource "aws_autoscaling_group" "autoscaling" {
  name = "saiautoscalinggroup"
  #availability_zones  = var.availability_zones
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = var.private_subnet_ids
  health_check_type   = "EC2"
  target_group_arns   = [var.target_group_arns]


  launch_template {
    id      = aws_launch_template.launchtemp.id
    version = "$Latest"
  }


}
