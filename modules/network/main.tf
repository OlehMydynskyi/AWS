resource "aws_vpc" "vpc" {
    cidr_block       = var.vpc_cidr
    instance_tenancy = var.instance_tenancy

    tags = {
        Name = var.vpc_name
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "pub-rt" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    } 
}

resource "aws_subnet" "public_subnet" {
  count = length(var.pub_subnet_cidrs)

  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.pub_subnet_cidrs, count.index)

  tags = {
    Name = format("Public-subnet-%d", count.index + 1)
  }
}

resource "aws_route_table_association" "PublicRTassociation" {
  count = length(var.pub_subnet_cidrs)

  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.pub-rt.id
}

resource "aws_default_security_group" "sg" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}