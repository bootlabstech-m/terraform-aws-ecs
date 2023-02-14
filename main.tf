# # iam.tf | IAM Role Policies

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = var.ecs_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = var.ecs_cluster_name

}

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family                   = "${var.app_name}-task"
  requires_compatibilities = var.requires_compatibilities
  cpu                      = var.cpu_size
  memory                   = var.memory_size
  network_mode             = var.network_mode

  execution_role_arn    = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn         = aws_iam_role.ecsTaskExecutionRole.arn
  container_definitions = var.container_definitions
  runtime_platform {
    operating_system_family = var.operating_system_family
    cpu_architecture        = var.cpu_architecture
  }

}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.aws-ecs-cluster.arn
  task_definition = aws_ecs_task_definition.aws-ecs-task.arn
  network_configuration {
    security_groups = var.security_groups
    subnets         = var.subnets
  }
}