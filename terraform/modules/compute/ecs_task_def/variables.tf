variable "tags" {
  description = "tags to be added"
  type        = map(string)
  default = {
    "classification" = "internal/sensitive"
  }
}

variable "taskdef_family_name" {
  type        = string
  description = "The name of a task definition"
  default     = "terraform-test"
}

variable "container_definitions" {
  type        = string
  description = "This container configuration json"
  default     = ""
}

variable "task_role_arn" {
  type        = string
  description = "ARN of the task role"
  default     = ""
}

variable "execution_role_arn" {
  type        = string
  description = "ARN of the task execution role"
  default     = ""
}

variable "network_mode" {
  type        = string
  description = "network mode of the task definiton"
  default     = "bridge"
}

variable "volumes" {
  description = "(Optional) A set of volume blocks that containers in your task may use"
  type = list(object({
    host_path = string
    name      = string
  }))
  default = []
}
