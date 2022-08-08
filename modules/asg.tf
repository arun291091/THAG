resource "aws_launch_template" "thag" {
  name_prefix   = "thag"
  image_id      = data.aws_ami.amazon-2.id
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "thag" {
  availability_zones = ["us-west-1a", "us-west-1b", "us-west-1c"]
  desired_capacity   = 3
  max_size           = 5
  min_size           = 2

  launch_template {
    id      = aws_launch_template.thag.id
    version = aws_launch_template.thag.latest_version
  }
}


  
  resource "aws_autoscaling_attachment" "thag_asg_Attachment" {
  autoscaling_group_name = aws_autoscaling_group.thag.id
  lb_target_group_arn    = aws_lb_target_group.thag.arn
}
