provider "aws" {
  region = "us-west-2"
  profile = "default"
}

resource "aws_lb" "alb" {
  name = var.alb_name

  load_balancer_type = var.load_balancer_type
  internal           = var.is_internal
  security_groups    = var.alb_sg_id         #### Enter SG list
  subnets            = var.subnets_id_list   #### Enter Subnet list

  idle_timeout                     = var.idle_timeout
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_deletion_protection       = var.enable_deletion_protection
  enable_http2                     = var.enable_http2
  ip_address_type                  = var.ip_address_type
  drop_invalid_header_fields       = var.drop_invalid_header_fields
  tags = var.elb_tags
}

resource "aws_lb_target_group" "target_group" {
  name = var.target_group_name
  vpc_id   = var.vpc_id
  port     = var.target_group_port
  protocol = var.target_group_protocol

  dynamic "health_check" {
    for_each = length(var.health_check) > 0 ? var.health_check : []

    content {
      enabled             = lookup(health_check.value, "enabled", null)
      interval            = lookup(health_check.value, "interval", null)
      path                = lookup(health_check.value, "path", null)
      port                = lookup(health_check.value, "port", null)
      healthy_threshold   = lookup(health_check.value, "healthy_threshold", null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
      timeout             = lookup(health_check.value, "timeout", null)
      protocol            = lookup(health_check.value, "protocol", null)
      matcher             = lookup(health_check.value, "matcher", null)
    }
  }
  tags = var.target_group_tags
  depends_on = [aws_lb.alb]

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port     = var.http_listener_port
  protocol = var.http_listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

//resource "aws_iam_role" "instance_role" {
//  name = var.instance_role_name
//  assume_role_policy = file("${path.module}/ec2_iam_assume_role_policy.json")
//  tags = var.iam_role_tags
//}
//
//resource "aws_iam_instance_profile" "instance_profile" {
//  name = var.instance_profile_name
//  role = aws_iam_role.instance_role.name
//}
//
//resource "aws_iam_role_policy" "instance_access_policy" {
//  name = var.instance_access_policy_name
//  role = aws_iam_role.instance_role.id
//  policy = file("${path.module}/ec2_iam_policy.json")
//}
//
//resource "tls_private_key" "mediawiki_pvt_key" {
//  algorithm = "RSA"
//  rsa_bits  = 2048
//}
//
//resource "aws_key_pair" "mediawiki_key_pair" {
//  key_name   = var.key_pair_name
//  public_key = tls_private_key.mediawiki_pvt_key.public_key_openssh
//}
//
//resource "aws_launch_configuration" "launch_config" {
//  name                 = var.lc_name
//  image_id             = var.ami_id
//  instance_type        = var.instance_type
//  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
//  key_name             = var.key_pair_name
//  security_groups      = var.ec2_sg_id
//  user_data            = file("${path.module}/user_data.sh")
//  lifecycle {
//    create_before_destroy = true
//  }
//
//}
//
//resource "aws_autoscaling_group" "main_asg" {
//  depends_on           = [aws_launch_configuration.launch_config]
//  name                 = var.asg_name
//  vpc_zone_identifier  = var.private_subnet_ids
//  launch_configuration = aws_launch_configuration.launch_config.id
//  max_size             = var.max_instance_count
//  min_size             = var.min_instance_count
//  desired_capacity     = var.desired_instance_count
//  health_check_type    = var.health_check_type
//  target_group_arns    = [aws_lb_target_group.target_group.arn]
//  dynamic "tag" {
//    for_each = var.asg_tags
//    content {
//      key                 = tag.key
//      value               = tag.value
//      propagate_at_launch = true
//    }
//  }
//}