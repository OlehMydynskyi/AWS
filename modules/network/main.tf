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

resource "aws_default_route_table" "default_rt" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "MAIN"
  } 
}

resource "aws_subnet" "public_subnet" {
  count = length(var.pub_subnet_cidrs)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.pub_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = format("Public-subnet-%d%s", count.index + 1, substr(element(var.azs, count.index), -1, 0))
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.pr_subnet_cidrs)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.pr_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = format("Private-subnet-%d%s", count.index + 1, substr(element(var.azs, count.index), -1, 0))
  }
}

resource "aws_eip" "nat_eip" {

  tags = {
    Name = "Nat-eip"
  }
}

resource "aws_nat_gateway" "private_ng" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "Pr-nat-gateway"
  }
}

resource "aws_route_table" "Private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private_ng.id
  }

  tags = {
    Name = "Private-rt"
  } 
}

resource "aws_route_table_association" "Private_rt_association" {
  count = length(var.pr_subnet_cidrs)

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.Private_rt.id
}

resource "aws_default_security_group" "sg" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}