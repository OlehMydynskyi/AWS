resource "aws_instance" "public_instance" {
  count = length(var.public_subnet_ids)

  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_pair_name
  subnet_id       = element(var.public_subnet_ids, count.index)
  security_groups = var.sg_id
  user_data       = file(var.user_data)

  tags = {
    Name = format("Public-instance-%d", count.index + 1)
  }
}

resource "aws_instance" "private_instance" {
  count = length(var.private_subnet_ids)

  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_pair_name
  subnet_id       = element(var.private_subnet_ids, count.index)
  security_groups = var.sg_id
  user_data       = file(var.user_data)

  tags = {
    Name = format("Private-instance-%d", count.index + 1)
  }
}