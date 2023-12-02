variable "name" {
  type = string
  description = "IAM User name"

  # validation {
  #   condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]{3,20}", var.name))
  #   error_message = "Invalid name: Start with letter, only letters, numbers and '-'"
  # }
}

variable "tags" {
    type = map(string)
    description = "IAM User tags"
}

variable "path" {
  type = string
  description = "IAM User path"
  default = null
}

variable "permissions_boundary" {
  type = string
  description = "IAM user permissions boundary ARN."
  default = null
}

variable "force_destroy" {
  type = bool
  description = "Destroy non terraform related resources"
  default = true
}
