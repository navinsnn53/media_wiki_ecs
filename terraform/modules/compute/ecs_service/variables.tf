variable "associate_alb" {
  description = "Whether to associate an Application Load Balancer (ALB) with the ECS service."
  default     = false
  type        = bool
}

variable "ecs_service_name" {
  description = "The service name."
  type        = string
}

variable "ecs_cluster_arn" {
  description = "ECS cluster arn for this task."
  type        = string
}

variable "task_definition_arn" {
  description = "The arn of task definition"
  type        = string
}
variable "tasks_desired_count" {
  description = "The number of instances of a task definition."
  default     = 1
  type        = number
}
variable "tasks_minimum_healthy_percent" {
  description = "Lower limit on the number of running tasks."
  default     = 100
  type        = number
}
variable "tasks_maximum_percent" {
  description = "Upper limit on the number of running tasks."
  default     = 200
  type        = number
}

variable "service_iam_role" {
  description = "The name of the servuce role"
  default     = ""
  type        = string
}
variable "ecs_service_ordered_placement_strategy" {
  description = "Service level strategy rules that are taken into consideration during task placement"
  type        = list(map(string))
  default = [
    {
      type  = "spread"
      field = "attribute:ecs.availability-zone"
    },
    {
      type  = "spread"
      field = "instanceId"
    }
  ]
}
variable "ecs_capacity_provider_strategy" {
  description = "The capacity provider strategy to use for the service. Can be one or more. Defined below."
  type        = list(map(string))
  default     = []
}
variable "ecs_placement_constraints" {
  description = "The placement constraints for the service. Can be one or more. Defined below."
  type        = list(map(string))
  default     = []
}
variable "ecs_target_group_arn" {
  description = "The arn of target group"
  type        = string
  default     = ""
}
variable "container_name" {
  description = "The name of container"
  type        = string
  default     = ""
}

variable "deployment_controller" {
  description = "configuration block supports the following ECS, CODE_DEPLOY, ECS, EXTERNAL"
  type        = string
  default     = "ECS"
}