resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  subnet_id                   = var.subnet_id
  security_groups             = var.sg_id
  user_data                   = var.user_data
  associate_public_ip_address = true

  tags = {
    Name = var.inst_name
  }
}