########
#Project variables
########
variable "name" {
    type = string
    description = "Main project name"

    validation {
      condition = can(regex("^[a-zA-Z][a-zA-Z0-9-]{3,20}",var.name))
      error_message = "Invalid Username: Start with letter, only letters, numbers and '-'"
    }
}

variable "region" {
    type = string
    description = "Main vpc region"
}

########
#Network variables
########
variable "cidr" {
    type = string
    description = "Main vpc cidr"
}

variable "public_subnet_count" {
    type = string
    description = "Main Public subnet count"
}

variable "private_subnet_count" {
    type = string
    description = "Main Private subnet count"
}

########
#Instance variables
########
variable "instance_count" {
    type = number
    description = "Main Instance count"

    validation {
      condition = var.instance_count < 10
      error_message = "Play it safe dey, soulja. Set instances to 10 or less."

    }
}
#user data file
variable "user_data" {
    type = string
    description = "Main instance user data"
    default = "sample_userdata_debian.sh"
}

variable "instance_type" {
    type = string
    description = "Main instance type"
    default = "t3.micro"
}

variable "key_name" {
    type = string
    description = "Main instance key name"
}
#Open these ports to the instance security groups
variable "port_list" {
    type = list(number)
    description = "Main instance port list"
    default = [80,22]
}