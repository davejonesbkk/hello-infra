#Create key-pair for logging into ec2 us-east-1
resource "aws_key_pair" "web-key" {
  provider   = aws.region
  key_name   = "web-key"
  public_key = file(var.key_path)
}

resource "aws_launch_template" "web-template" {
  provider               = aws.region
  name_prefix            = "web-template"
  instance_type          = "t2.micro"
  image_id               = "ami-0947d2ba12ee1ff75"
  key_name               = aws_key_pair.web-key.key_name
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  user_data              = filebase64("test.sh")

  depends_on = [aws_security_group.web-sg]

  tags = {
    Name = "web-server"
  }
}


resource "aws_autoscaling_group" "web-asg" {
  provider                  = aws.region
  name                      = "web-asg"
  max_size                  = 2
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  target_group_arns         = [aws_lb_target_group.web-lb-tg.arn]
  vpc_zone_identifier       = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  launch_template {
    id = aws_launch_template.web-template.id
  }

  depends_on = [aws_security_group.web-sg, aws_subnet.subnet_1, aws_subnet.subnet_2, aws_lb_target_group.web-lb-tg]

}

