# --------------------------------------------
# APPLICATION LOAD BALANCER (ALB)
# --------------------------------------------

resource "aws_security_group" "alb_sg" {
  name   = "sample-alb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "alb" {
  name               = "springboot-alb"
  load_balancer_type = "application"
  internal           = false

  subnets         = var.public_subnets
  security_groups = [aws_security_group.alb_sg.id]

  tags = {
    Name = "springboot-alb"
  }
}

# --------------------------------------------
# TARGET GROUP
# --------------------------------------------

resource "aws_lb_target_group" "tg" {
  name        = "springboot-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/actuator/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "springboot-tg"
  }
}

# --------------------------------------------
# LISTENER
# --------------------------------------------

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}