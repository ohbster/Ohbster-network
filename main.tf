terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = var.region
  
}

module "vpc-network" {
    name = var.name
    source = "./modules/network"
    region = var.region
    cidr = var.cidr
    public_subnet_count = var.public_subnet_count
    private_subnet_count = var.private_subnet_count
    tags = var.common_tags

}
module "instance" {
    #The count will `instance_count` # of instances. Set this in the terraform.tfvar file
    count = var.instance_count 
    source = "./modules/instance"
    name = "${var.name}-instance-${count.index + 1}" #This will add the number of the instance to the name
    #This will evenly distribute instances in the available public subnets
    subnet_id = module.vpc-network.public_subnet_ids[count.index % module.vpc-network.public_subnet_count] 
    vpc_id = module.vpc-network.vpc_id
    user_data = var.user_data
    instance_type = var.instance_type
    key_name = var.key_name
    port_list = var.port_list
    tags = var.common_tags
}