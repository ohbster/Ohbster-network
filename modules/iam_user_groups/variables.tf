# variable "group_count" {
#   type = number
# }
variable "name" {
  type = string
  
}
variable "path" {
  type = string
  
}
# variable "group_list" {
#   type = map(list(string))
# }
variable "user_list" {
  type = list(string)
}
variable "permission_list" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}