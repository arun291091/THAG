
resource "aws_lb" "thag" {
  name               = "thag-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  enable_deletion_protection = false

  tags = {
    Environment = "dev"
  }
}


resource "aws_lb_target_group" "thag" {
  name        = "thag"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.base.id
}


resource "aws_lb_listener" "lb_listner_https_test" {
  load_balancer_arn = aws_lb.thag.id
  port              = "80"
  protocol          = "HTTP"
  default_action {
     type             = "forward"
     target_group_arn = aws_lb_target_group.thag.id
  }
}


