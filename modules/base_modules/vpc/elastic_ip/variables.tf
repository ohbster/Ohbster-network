variable "name" {
    type = string
    description = "Elastic IP Name"
}
variable "vpc" {
    type = bool
    description = "Elastic IP VPC"
    default = true
}
