resource "aws_ecs_service" "ecs_service_without_alb" {
  count = var.associate_alb ? 0 : 1

  name                               = var.ecs_service_name
  cluster                            = var.ecs_cluster_arn
  task_definition                    = var.task_definition_arn
  desired_count                      = var.tasks_desired_count
  deployment_minimum_healthy_percent = var.tasks_minimum_healthy_percent
  deployment_maximum_percent         = var.tasks_maximum_percent
  iam_role                           = var.service_iam_role

  dynamic capacity_provider_strategy {
    for_each = var.ecs_capacity_provider_strategy

    content {
      capacity_provider = capacity_provider_strategy.value.name
      weight            = capacity_provider_strategy.value.weight
      base              = capacity_provider_strategy.value.base
    }
  }

  dynamic ordered_placement_strategy {
    for_each = var.ecs_service_ordered_placement_strategy

    content {
      type  = ordered_placement_strategy.value.type
      field = ordered_placement_strategy.value.field
    }
  }
  deployment_controller {
    type = var.deployment_controller
  }
  dynamic "placement_constraints" {
    for_each = var.ecs_placement_constraints

    content {
      type       = placement_constraints.value.type
      expression = placement_constraints.value.expression
    }
  }
}