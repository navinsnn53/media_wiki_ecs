##################### Network #########################

################################ VPC ####################################
vpc_cidr ="10.96.0.0/16"

########################### Subnet ####################################

az_a = "us-west-2a"
az_b = "us-west-2b"
subnets_cidr_public_a = "10.96.1.0/24"
subnets_cidr_public_b = "10.96.2.0/24"
subnets_cidr_private_a = "10.96.3.0/24"
subnets_cidr_private_b = "10.96.4.0/24"
subnet_name_public_a = "public_subnet_a"
subnet_name_public_b = "public_subnet_b"
subnet_name_private_a = "private_subnet_a"
subnet_name_private_b = "private_subnet_b"

######################## Route Table ########################

route_cidr_block = "0.0.0.0/0"
public_route_table_tags = {"Name"="public_route_table"}
private_route_table_tags = {"Name" = "private_route_table"}

################### ECS Component #####################

################### ECS Cluster ###################
ecs_lc_name               = "mediawiki"
env                       = "dev"
ecs_ami_id                = "ami-0809dffbdbc343898"
ecs_instance_type         = "c5.large"
ecs_key_name              = "events-dev"
ecs_sg_list_id            = ["sg-032e08630827ea4cb","sg-0b55d4df85d8bfa9b","sg-0b9aaece10464eff8"]
ecs_cluster_name          = "ecs_mediawiki"
ecs_asg_name              = "asg-media"
ecs_asg_max_size          = "10"
ecs_asg_min_size          = "0"
ecs_asg_desired_size      = "1"
ecs_asg_subnet_list_id    = ["subnet-00459dcd251529635","subnet-07ba3897b78d4eade"]
ecs_instance_volume       = "30"
ecs_asg_instance_health_check_period = "30"
ecs_asg_protect_scale_in = "false"
