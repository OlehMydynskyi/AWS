output "public_subnet_id" {
    value = aws_subnet.public_subnet[*].id
}

output "private_subnet_id" {
    value = aws_subnet.private_subnet[*].id
}

output "sg_id" {
    value = aws_default_security_group.sg.id
}