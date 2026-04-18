# --------------------------------------------
# NOTE (IMPORTANT)
# --------------------------------------------

# This is a simplified ECS module for demonstration purposes.
# It shows how ECS integrates with ALB and VPC networking.

# Some production configurations are intentionally omitted:
# - IAM roles and policies
# - Secrets and environment variables
# - Logging configuration
# - Real container image (uses placeholder)

# This module is meant to illustrate architecture and flow,
# not to be directly used for deployment.


# --------------------------------------------
# ECS INFRASTRUCTURE
# --------------------------------------------

resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_iam_role" "execution_role" {
  name = "ecsTaskExecutionRole"
}

resource "aws_iam_role_policy_attachment" "ecs_policy" {
  role       = data.aws_iam_role.execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_security_group" "ecs_sg" {
  name   = "ecs-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --------------------------------------------
# ECS TASK DEFINITION (SIMPLIFIED)
# --------------------------------------------

# Defines how the container runs in ECS (Fargate)

resource "aws_ecs_task_definition" "app" {
  family                   = "sample-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "app"
      image = "example/app:latest"  # placeholder image

      portMappings = [
        {
          containerPort = 8080
        }
      ]
    }
  ])
}

# --------------------------------------------
# ECS SERVICE
# --------------------------------------------

# Runs and maintains the application tasks

resource "aws_ecs_service" "app" {
  name            = "sample-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1

  launch_type = "FARGATE"

  network_configuration {
    subnets = var.private_subnets
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "app"
    container_port   = 8080
  }
}