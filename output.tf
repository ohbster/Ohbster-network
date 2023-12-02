output "public_ips" {
  value = [
    for instance in module.instance : instance.ip
  ]

}

output "passwords" {
  value = [for pw in module.iam_user_group : pw.password]
}