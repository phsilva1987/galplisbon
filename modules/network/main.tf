resource "aws_vpc" "main" {
  cidr_block = var.Network_CIDR

  tags = {
    Name = var.Name
  }
}

resource "aws_subnet" "public" {
  count             = var.N_subnets / 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.Network_CIDR, 4, count.index)
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.Name}-public-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count             = var.N_subnets / 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.Network_CIDR, 4, count.index + (var.N_subnets / 2))
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.Name}-private-${count.index}"
  }
}

output "Network" {
  value = {
    vpc_id    = aws_vpc.main.id
    subnet_ids = concat(aws_subnet.public[*].id, aws_subnet.private[*].id) //concat to unify the strings

  }
}