output "password" {
    
    #value = [for sn in aws_iam_user_login_profile.login : "${var.name} : ${sn.password}"]
    value = [for sn in module.login_profile : "(${var.name})${sn.name} => ${sn.password} "]
}

# output "name" {
#     value = 
# }