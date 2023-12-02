output "password" {
    value = [for sn in module.login_profile : "(${var.name})${sn.name} => ${sn.password} "]
}

