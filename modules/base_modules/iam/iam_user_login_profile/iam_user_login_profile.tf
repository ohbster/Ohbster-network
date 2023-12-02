resource "aws_iam_user_login_profile" "login" {
  #count = length(var.user_list)
  user = var.user

}