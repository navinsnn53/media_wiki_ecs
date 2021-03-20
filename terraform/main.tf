provider "aws" {
  region = "us-west-2"
  profile = "default"
}

######### NetWork ##################

################################ VPC ########################################
module "vpc" {
  source = "./modules/network/vpc"
  cidr   = var.vpc_cidr
}

output "vpc_id" {
  value = module.vpc.vpc_id
}


################### Subnet ##############################

module "public_subnet_a" {
  source = "./modules/network/subnet"
  vpc_id = module.vpc.vpc_id
  subnets_cidr = var.subnets_cidr_public_a
  azs     = var.az_a
  subnet_name = var.subnet_name_public_a
}

module "public_subnet_b" {
  source = "./modules/network/subnet"
  vpc_id = module.vpc.vpc_id
  subnets_cidr = var.subnets_cidr_public_b
  azs     = var.az_b
  subnet_name = var.subnet_name_public_b
}
module "private_subnet_a" {
  source = "./modules/network/subnet"
  vpc_id = module.vpc.vpc_id
  subnets_cidr = var.subnets_cidr_private_a
  azs     = var.az_a
  subnet_name = var.subnet_name_private_a
}

module "private_subnet_b" {
  source = "./modules/network/subnet"
  vpc_id = module.vpc.vpc_id
  subnets_cidr = var.subnets_cidr_private_b
  azs     = var.az_b
  subnet_name = var.subnet_name_private_b
}

############################ Gateway ############################
module "igw" {
  source = "./modules/network/IGW"
  vpc_id = module.vpc.vpc_id
}


module "nat" {
  source = "./modules/network/NAT"
  public_subnet = module.public_subnet_a.subnet_id
}

############################ Route Table ############################

module "public_route" {
  source = "./modules/network/Route_Table"
  vpc_id = module.vpc.vpc_id
  route_cidr_block = var.route_cidr_block
  gateway_id = module.igw.igw_id
  route_table_tags = var.public_route_table_tags
}

module "private_route" {
  source = "./modules/network/Route_Table"
  vpc_id = module.vpc.vpc_id
  route_cidr_block = var.route_cidr_block
  gateway_id = module.nat.nat_id
  route_table_tags = var.private_route_table_tags
}

module "public_route_table_association_a" {
  source = "./modules/network/route_table_association"
  subnet = module.public_subnet_a.subnet_id
  route_table = module.public_route.route_table_id
}

module "public_route_table_association_b" {
  source = "./modules/network/route_table_association"
  subnet = module.public_subnet_b.subnet_id
  route_table = module.public_route.route_table_id
}

############################ Route Table Association ############################

module "private_route_table_association_a" {
  source = "./modules/network/route_table_association"
  subnet = module.private_subnet_a.subnet_id
  route_table = module.private_route.route_table_id
}

module "private_route_table_association_b" {
  source = "./modules/network/route_table_association"
  subnet = module.private_subnet_b.subnet_id
  route_table = module.private_route.route_table_id
}

########## ECS Components #################


module "aws_ecs_cluster" {
  source                  = "./modules/compute/ecs_cluster"
  ecs_lcv_name            = "${var.ecs_lc_name}-${var.env}"
  ecs_ami_id              = var.ecs_ami_id
  ecs_instance_type       = var.ecs_instance_type
  ecs_key_name            = var.ecs_key_name
  security_group_list     = var.ecs_sg_list_id
  cluster_name            = var.ecs_cluster_name
  asg_name                = "${var.ecs_asg_name}-${var.env}"
  ecs_asg_max_size        = var.ecs_asg_max_size
  ecs_asg_min_size        = var.ecs_asg_min_size
  ecs_asg_desired_size    = var.ecs_asg_desired_size
  ecs_asg_subnet_id       = var.ecs_asg_subnet_list_id
  ecs_instance_volume_size = var.ecs_instance_volume
  health_check_grace_period = var.ecs_asg_instance_health_check_period
  protect_from_scale_in   = var.ecs_asg_protect_scale_in
  user_data = templatefile("${path.module}/ecs_user_data.sh", {
    ecs_cluster_name = var.ecs_cluster_name
    env = var.env
  })
  tags = {
    "Name" = "ecs-media-${var.env}",
    "tier" = var.env
    "Project" = "events"
    "instancetype" = "consumerinstance-${var.env}"
  }
}


module "aws_taskdef" {
  source                  = "./modules/compute/ecs_task_def"
  taskdef_family_name     = "hazelcast"
  container_definitions     = templatefile("${path.module}/media_wiki.json",{
    env = var.env
  })
}


module "aws_ecs_service_wiki" {
  source = "./modules/compute/ecs_service"
  ecs_service_name        = "media_wiki"
  ecs_cluster_arn         = module.aws_ecs_cluster.aws_ecs_cluster_arn
  task_definition_arn     = module.aws_taskdef.aws_ecs_task_definition_arn
  tasks_desired_count     = "0"
}









