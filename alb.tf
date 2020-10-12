resource "aws_lb" "web-lb" {
  provider           = aws.region
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-sg.id]
  subnets            = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  tags = {
    Name = "Web-LB"
  }
}

resource "aws_lb_target_group" "web-lb-tg" {
  provider    = aws.region
  name        = "web-lb-tg"
  port        = var.webserver-port
  target_type = "instance"
  vpc_id      = aws_vpc.vpc_us.id
  protocol    = "HTTP"
  health_check {
    enabled  = true
    interval = 10
    path     = "/"
    port     = var.webserver-port
    protocol = "HTTP"
    matcher  = "200-299"
  }
  tags = {
    Name = "web-target-group"
  }
}

resource "aws_lb_listener" "web-listener-http" {
  provider          = aws.region
  load_balancer_arn = aws_lb.web-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-lb-tg.id
  }
}
