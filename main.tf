terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  alias = "region-1"
  region = var.region

}
provider "aws" {
  alias = "region-2"
  region = var.region2
}

module "vpc-network" {
  providers = {
    aws = aws.region-1
  }
  name                 = var.name
  source               = "./modules/network"
  region               = var.region
  cidr                 = var.cidr
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  tags                 = var.common_tags

}

# module "vpc-network-2" {
#   providers = {
#     provider = aws.us-east-1
#     provider = aws.us-west-2
#   }
#   name                 = var.name
#   source               = "./modules/network"
#   region               = var.region2
#   cidr                 = var.cidr
#   public_subnet_count  = var.public_subnet_count
#   private_subnet_count = var.private_subnet_count
#   tags                 = var.common_tags

# }

module "ec2_instance_sg" {
  source    = "./modules/security_group"
  name      = var.name
  port_list = var.port_list
  vpc_id    = module.vpc-network.vpc_id
  tags      = var.common_tags
}
module "instance" {
  #The count will `instance_count` # of instances. Set this in the terraform.tfvar file
  count  = var.instance_count
  source = "./modules/instance"
  name   = "${var.name}-instance-${count.index + 1}" #This will add the number of the instance to the name
  #This will evenly distribute instances in the available public subnets
  subnet_id          = module.vpc-network.public_subnet_ids[count.index % module.vpc-network.public_subnet_count]
  vpc_id             = module.vpc-network.vpc_id
  user_data          = var.user_data
  instance_type      = var.instance_type
  key_name           = var.key_name
  port_list          = var.port_list
  tags               = var.common_tags
  security_group_ids = [module.ec2_instance_sg.security_group_id]
}

module "iam_user_group" {
  source = "./modules/iam_user_groups"
  for_each = var.group_list
  #group_list = var.group_list
  #name = var.each.key
  user_list = each.value
  path = var.path
  name = "${each.key}-grp"
  tags = var.common_tags
}

# module "iam_user" {
#   #count = var.toggle_map.iam_toggle ? length(var.user_list) : 0
#   source = "./modules/iam_user"
#   for_each = var.group_list 
#   group_name = each.key
#   name = var.user_list[count.index]
#   tags = var.common_tags
#   #path = module.iam_group[0].path
#   user_list = each.value
# }