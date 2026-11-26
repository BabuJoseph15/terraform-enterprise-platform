resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${var.project_name}-${var.environment}"
  retention_in_days = 7
}

resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-${var.environment}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-cluster"
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.project_name}-${var.environment}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = 256
  memory = 512

  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn      = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name = "${var.project_name}-${var.environment}"

      image = "${var.ecr_repository_url}:latest"

      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.this.name
          awslogs-region        = "ap-southeast-2"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = {
    Name = "${var.project_name}-${var.environment}-task-definition"
  }
}

resource "aws_ecs_service" "this" {
  name = "${var.project_name}-${var.environment}-service"

  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn

  desired_count = var.desired_count

  launch_type = "FARGATE"

  network_configuration {
    subnets = var.public_subnet_ids

    security_groups = [
      var.ecs_security_group_id
    ]

    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn

    container_name = "${var.project_name}-${var.environment}"

    container_port = var.container_port
  }

  depends_on = [
    aws_ecs_task_definition.this
  ]

  tags = {
    Name = "${var.project_name}-${var.environment}-service"
  }
}
