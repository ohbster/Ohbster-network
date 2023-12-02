variable "user_list" {
    type = list(string)
    description = "IAM Group Membership"
}

variable "group" {
    type = string
    description = "IAM Group Membership group"
}

variable "name" {
    type = string
    description = "Group Membership name"
}