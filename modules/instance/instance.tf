data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
# data "aws_ami" "amazon_linux" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["al2023-ami-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["137112412989"] # Canonical
# }
module "ec2_instance_sg" {
  source = "../security_group"
  name = var.name
  #port_list = [80,22]
  port_list = var.port_list
  vpc_id = var.vpc_id
}


resource "aws_instance" "web" {
    ami = data.aws_ami.ubuntu.id 
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    #security_groups = [aws_security_group.webserver.id]
    security_groups = [module.ec2_instance_sg.security_group_id]
    associate_public_ip_address = true
    user_data = file("${var.user_data}")
    key_name = var.key_name
    metadata_options {
      http_endpoint = "enabled"
      http_tokens = "required"  
    }
    
    tags = {
        Name = "${var.name}"
    }
}
# resource "aws_network_interface" "eni" {
#     subnet_id = aws_instance.web.subnet_id
#     #private_ips = ["${}"]
#     security_groups = var.security_group_ids

#     attachment {
#         instance = aws_instance.web.id
#         device_index = 0
#     }
# }
