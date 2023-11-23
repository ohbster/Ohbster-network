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
    public_subnet_count = 3
    private_subnet_count = 3

}
module "instance" {
    count = var.instance_count 
    source = "./modules/instance"
    name = "${var.name}-instance-${count.index + 1}"
    subnet_id = module.vpc-network.public_subnet_ids[count.index % module.vpc-network.public_subnet_count]
    vpc_id = module.vpc-network.vpc_id
    user_data = var.user_data
    instance_type = var.instance_type
    key_name = var.key_name
    port_list = var.port_list
}