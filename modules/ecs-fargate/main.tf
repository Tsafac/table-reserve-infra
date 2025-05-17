resource "aws_ecs_cluster" "main" {
  name = "${var.project}-cluster"

   tags = merge(var.default_tags, {
    Name = "${var.domain_name}-cluster"
  })
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn = module.iam.ecs_execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = var.image_url
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "ENV"
          value = var.environment
        }
      ]
      secrets = [
        {
          name      = "DB_USERNAME"
          valueFrom = "${var.aurora_secret_arn}:username::"
        },
        {
          name      = "DB_PASSWORD"
          valueFrom = "${var.aurora_secret_arn}:password::"
        },
        {
          name      = "DB_HOST"
          valueFrom = "${var.aurora_secret_arn}:host::"
        },
        {
          name      = "DB_NAME"
          valueFrom = "${var.aurora_secret_arn}:dbname::"
        },
        {
          name      = "DB_PORT"
          valueFrom = "${var.aurora_secret_arn}:port::"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = "${var.project}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  platform_version         = "LATEST"
  enable_ecs_managed_tags  = true

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  network_configuration {
    subnets          = var.private_subnets
    security_groups = [var.ecs_sg_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "app"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.https]

  tags = merge(var.default_tags, {
    Name = "${var.domain_name}-cluster"
  })
}
