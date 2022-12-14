resource "aws_launch_template" "thag" {
  name_prefix   = "thag"
  image_id      = data.aws_ami.amazon-2.id
  instance_type = "t2.micro"
  user_data = filebase64("${path.module}/init.sh")
}

resource "aws_autoscaling_group" "thag" {
  desired_capacity   = 3
  max_size           = 5
  min_size           = 2
  target_group_arns = [aws_lb_target_group.thag.arn]
  wait_for_capacity_timeout = "5m"
  vpc_zone_identifier = [for subnet in aws_subnet.private : subnet.id]

  launch_template {
    id      = aws_launch_template.thag.id
    version = aws_launch_template.thag.latest_version
  }
  depends_on = [aws_vpc.base]
}

/*
  resource "aws_autoscaling_attachment" "thag_asg_Attachment" {
  autoscaling_group_name = aws_autoscaling_group.thag.id
  lb_target_group_arn    = aws_lb_target_group.thag.arn
}
*/
