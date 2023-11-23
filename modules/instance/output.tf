output "latest_ubuntu" {
    value = data.aws_ami.ubuntu.id 
}
output "ip" {
    value = aws_instance.web.public_ip
}