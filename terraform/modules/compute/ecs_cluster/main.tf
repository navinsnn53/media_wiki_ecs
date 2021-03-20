resource "aws_launch_configuration" "ecs_lcv" {
  name_prefix                 = var.ecs_lcv_name
  image_id                    = var.ecs_ami_id
  instance_type               = var.ecs_instance_type
  iam_instance_profile        = var.ecs_instance_profile
  key_name                    = var.ecs_key_name
  security_groups             = var.security_group_list
  user_data                   = var.user_data
  associate_public_ip_address = "false"
  lifecycle {
    create_before_destroy = true
  }
  root_block_device {
    volume_size = var.ecs_instance_volume_size
    encrypted   = true
  }
  dynamic "ebs_block_device" {
    for_each = var.create_ebs == "true" ? [var.ebs_block_device] : []
    content {
      device_name = lookup(ebs_block_device.value, "device_name")
      volume_size = lookup(ebs_block_device.value, "volume_size")
      volume_type = lookup(ebs_block_device.value, "volume_type")
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination")
    }
  }
}


resource "aws_autoscaling_group" "ecs_asg" {
  depends_on                = [aws_launch_configuration.ecs_lcv]
  name                      = var.asg_name
  max_size                  = var.ecs_asg_max_size
  min_size                  = var.ecs_asg_min_size
  desired_capacity          = var.ecs_asg_desired_size
  launch_configuration      = aws_launch_configuration.ecs_lcv.id
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = "EC2"
  protect_from_scale_in     = var.protect_from_scale_in
  vpc_zone_identifier       = var.ecs_asg_subnet_id
  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_ecs_capacity_provider" "ecs_capacity_provider" {
  count = var.is_create_capacity_provider ? 1 : 0

  name = var.capacity_provider_name
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_asg.arn
    managed_termination_protection = var.capacity_provider_managed_termination_protection

    managed_scaling {
      maximum_scaling_step_size = var.cp_max_scaling_size
      minimum_scaling_step_size = var.cp_min_scaling_size
      status                    = "ENABLED"
      target_capacity           = var.cp_target_capacity
    }
  }
  tags = var.tags
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name               = var.cluster_name
  capacity_providers = var.is_create_capacity_provider ? [aws_ecs_capacity_provider.ecs_capacity_provider[0].name] : null
  tags               = var.tags
}


output "aws_ecs_cluster_arn" {
  value = aws_ecs_cluster.ecs_cluster.arn
}