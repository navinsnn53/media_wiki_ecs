variable "tags" {
  description = "tags to be added"
  type        = map(string)
  default = {
    "classification" = "internal/sensitive"
  }
}
variable "ecs_lcv_name" {
  description = "Name of your launch configuration"
}
variable "ecs_ami_id" {
  description = "The EC2 image ID to launch."
}
variable "ecs_instance_type" {
  default = "m5.large"
}
variable "ecs_instance_profile" {
  description = "The name attribute of the IAM instance profile to associate with launched instances."
  default = ""
}
variable "ecs_key_name" {
  description = "The key name that should be used for the instance."
}
variable "security_group_list" {
  description = "A list of associated security group IDS."
  type        = list
}
variable "ecs_instance_volume_size" {
  description = "The size of the volume in gigabytes."
  default     = "20"
}
variable "cluster_name" {
  description = "The name of the cluster (up to 255 letters, numbers, hyphens, and underscores)"
}
variable "asg_name" {
  description = "The name of the auto scaling group"
}
variable "ecs_asg_max_size" {
  description = " The maximum size of the auto scale group."
  default     = "3"
}
variable "ecs_asg_min_size" {
  description = "The minimum size of the auto scale group"
  default     = "3"
}
variable "ecs_asg_subnet_id" {
  description = " A list of subnet IDs to launch resources in"
  type        = list
}
variable "is_create_capacity_provider" {
  description = "true if you want it created"
  type        = bool
  default     = false
}
variable "capacity_provider_name" {
  description = "The name of the capacity provider."
  default     = "test"
}
variable "cp_max_scaling_size" {
  description = "The maximum step adjustment size. A number between 1 and 10,000."
  default     = "3"
}
variable "cp_min_scaling_size" {
  description = "The minimum step adjustment size. A number between 1 and 10,000."
  default     = "3"
}
variable "cp_target_capacity" {
  description = "The target utilization for the capacity provider. A number between 1 and 100."
  default     = "75"
}

variable "health_check_grace_period" {
  description = "Health check for ec2 instance types"
  default     = "300"
}

variable "protect_from_scale_in" {
  description = "Enable scale in for Capacity Provider"
  default     = false
}

variable "ecs_asg_desired_size" {
  description = "Desired number of count"
  default     = 1
}

variable "capacity_provider_managed_termination_protection" {
  description = "capacity_provider_managed_termination_protection"
  default     = "DISABLED"
}

variable "ebs_block_device" {
  type        = map(string)
  default = {}
}

variable "create_ebs" {
  default = false
}

variable "user_data" {}