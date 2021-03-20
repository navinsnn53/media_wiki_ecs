########## ALB #############

variable "alb_name" {
  description = "The resource name and Name tag of the load balancer."
  type        = string
  default     = "alb-01"
}
variable "load_balancer_type" {
  description = "The type of load balancer to create. Possible values are application or network."
  type        = string
  default     = "application"
}

variable "is_internal"{
  description ="is ALB internal"
  type = bool
  default = false
}
variable "alb_sg_id" {
  default = ["sg-0915417ad6ed10210"]
}

variable "subnets_id_list" {
  description = "A list of subnets to associate with the load balancer. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']"
  type        = list(string)
  default     = ["subnet-0aae9a1810a2fe794","subnet-0dda01410b365d689"]
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  type        = number
  default     = 60
}
variable "enable_cross_zone_load_balancing" {
  description = "Indicates whether cross zone load balancing should be enabled in application load balancers."
  type        = bool
  default     = false
}
variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
  type        = bool
  default     = false
}
variable "enable_http2" {
  description = "Indicates whether HTTP/2 is enabled in application load balancers."
  type        = bool
  default     = true
}

variable "ip_address_type" {
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack."
  type        = string
  default     = "ipv4"
}

variable "drop_invalid_header_fields" {
  description = "Indicates whether invalid header fields are dropped in application load balancers. Defaults to false."
  type        = bool
  default     = false
}
variable "elb_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {
    "classificaton" = "internal/sensitive"
  }
}

variable "target_group_name" {
  description = "The resource name and Name tag of the TG"
  type        = string
  default     = "tg-01"
}

variable "vpc_id" {
  default = "vpc-05915138fe21939c6"
}
variable "target_group_port" {
  description = "Port of TG"
  type        = number
  default     = 80
}
variable "target_group_protocol" {
  description = "Protocol of TG"
  type  = string
  default = "HTTP"
}
variable "health_check" {
  description = "Health check settings"
  type = list(map(string))
  default = [{
    "path" = "/"
    "port" = "traffic-port"
    "protocol" = "HTTP"
  }]
}
variable "target_group_tags" {
  description = "Tags for the target group"
  type = map(string)
  default = {
    tier = "public"
  }
}

variable "http_listener_port" {
  description = "Listener port for HTTP"
  type = number
  default = 80
}

variable "http_listener_protocol" {
  description = "Listener protocol"
  type = string
  default = "HTTP"
}