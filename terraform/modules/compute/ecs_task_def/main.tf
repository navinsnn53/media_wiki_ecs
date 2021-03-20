
resource "aws_ecs_task_definition" "ecs_task_def" {
  family                = var.taskdef_family_name
  task_role_arn         = var.task_role_arn == "" ? null : var.task_role_arn
  execution_role_arn    = var.execution_role_arn == "" ? null : var.execution_role_arn
  network_mode          = var.network_mode
  tags                  = var.tags
  container_definitions = var.container_definitions
  dynamic "volume" {
    for_each = var.volumes
    content {
      name      = volume.value.name
      host_path = lookup(volume.value, "host_path", null)
    }
  }
}

output "aws_ecs_task_definition_arn" {
  value = aws_ecs_task_definition.ecs_task_def.arn
}
