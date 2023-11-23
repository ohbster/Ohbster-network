resource "aws_nat_gateway" "nat" {
    #allocation_id = aws_eip.nat.id
    allocation_id = var.allocation_id
    #subnet_id = element(module.public-subnets,0).id
    subnet_id = var.subnet_id
    tags = {
        Name = var.name
    }
    #depends_on = [ aws_internet_gateway.igw ]

}