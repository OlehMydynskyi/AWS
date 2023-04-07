data "template_file" "container" {
  template = file("${path.module}/templates/container.json.tpl")
  
  vars = {
    DOCKER_TAG     = var.docker_tag
    REPOSITORY_URL = var.repository_url
    APPLICATION    = var.application
  }
}

resource "aws_ecs_task_definition" "task-definition" {
  family                   = var.task_definition_family
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = data.template_file.container.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
}

resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.task-definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.public_subnet_id
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }
}