resource "aws_instance" "instance" {
  count = length(var.subnet_ids)

  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  subnet_id                   = element(var.subnet_ids, count.index)
  security_groups             = var.sg_id
  user_data                   = file(var.user_data)
  associate_public_ip_address = true

  tags = {
    Name = format("Public-instance-%d", count.index + 1)
  }
}