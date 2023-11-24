output "public_ips" {
  value = [
    for instance in module.instance : instance.ip
  ]

}