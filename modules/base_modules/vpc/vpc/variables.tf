#vpc
variable "name" {
    type = string
    description = "Name of vpc"
}
# variable "region" {
#     type = string
#     description = "Region of VPC"
#     default = "us-east-1"
# }
variable "cidr" {
    type = string
    description = "CIDR address block"
}