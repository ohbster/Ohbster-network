resource "aws_eip" "nat" {
    vpc = var.vpc
    tags = {
        Name = var.name
    }
}