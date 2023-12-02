
variable "name" {
  type = string
}
variable "path" {
  type = string
  
}
variable "user_list" {
  type = list(string)
}
variable "permission_list" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}