variable "name" {
  type = string
}
variable "user_list" {
    type = list(string)
}
variable "path" {
    type = string
    default = null
}
variable "tags" {
  type = map(string)
}
variable "group_name"{
  type = string
}