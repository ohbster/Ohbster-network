output "password" {
    
    #value = aws_iam_user_login_profile.login.password
    value = [for sn in aws_iam_user_login_profile.login : "${var.name} : ${sn.password}"]
}

# output "name" {
#     value = 
# }