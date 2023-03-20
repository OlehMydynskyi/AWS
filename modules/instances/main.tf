resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  subnet_id                   = var.subnet_id
  security_groups             = var.sg_id
  user_data                   = file(var.user_data)
  user_data_replace_on_change = true
  associate_public_ip_address = true

  tags = {
    Name = var.inst_name
  }
}