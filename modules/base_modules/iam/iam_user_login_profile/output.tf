output "name" {
  value = var.user
}

output "password" {
    value = aws_iam_user_login_profile.login.password
}