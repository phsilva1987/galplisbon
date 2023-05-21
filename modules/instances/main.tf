resource "aws_instance" "private" {
  count         = var.Network.subnet_ids_private != null ? length(var.Network.subnet_ids_private) : 0
  ami           = var.Image
  instance_type = "t2.micro"
  subnet_id     = element(var.Network.subnet_ids_private, count.index)
  key_name      = var.SSH_key_Content

  tags = {
    Name = "${var.Name}-private-${count.index}"
  }
}

resource "aws_instance" "bastion" {
  ami           = "ami-0889a44b331db0194"
  instance_type = "t2.micro"
  subnet_id     = element(var.Network.subnet_ids_public, 0)
  key_name      = var.SSH_key_Content

  tags = {
    Name = "${var.Name}-bastion"
  }
}

resource "aws_security_group" "bastion_sg" {
  vpc_id = var.Network.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.SSH_source]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.Name}-bastion-sg"
  }
}

resource "aws_security_group" "alb_sg" {
  vpc_id = var.Network.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.Name}-alb-sg"
  }
}

resource "aws_lb" "alb" {
  name               = "${var.Name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.Network.subnet_ids_public

  tags = {
    Name = "${var.Name}-alb"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.Name}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.Network.vpc_id

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_listener_rule" "alb_listener_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }

  condition {
    field  = "host-header"
    values = ["${aws_lb.alb.dns_name}"]
  }
}

