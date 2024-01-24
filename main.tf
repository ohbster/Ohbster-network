terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  alias  = "region-1"
  region = var.region

}
provider "aws" {
  alias  = "region-2"
  region = var.region2
}

#This is used by mff_id tag. This is will identify all resources that belong to the terraform deployment
resource "random_uuid" "uuid" {

}

#This will add the mff_id uuid to the common tags that get passed to resources. This will identify resources that belong to this deployment
locals {
  common_tags = merge(var.common_tags, { mff_id = random_uuid.uuid.result })
}

module "vpc-network" {
  name                 = var.name
  source               = "./modules/network"
  region               = var.region
  cidr                 = var.cidr
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  tags                 = local.common_tags

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
#   tags = local.common_tags

# }

module "ec2_instance_sg" {
  source    = "./modules/security_group"
  name      = var.name
  port_list = var.port_list
  vpc_id    = module.vpc-network.vpc_id
  tags      = local.common_tags
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
  tags               = local.common_tags
  security_group_ids = [module.ec2_instance_sg.security_group_id]
}

module "iam_user_group" {
  source          = "./modules/iam_user_groups"
  for_each        = var.group_map
  user_list       = each.value
  permission_list = var.action_map[each.key]
  path            = var.path
  name            = "${each.key}-grp"
  tags            = local.common_tags
}

