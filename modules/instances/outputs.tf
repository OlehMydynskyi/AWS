output "public_instance" {
    value = aws_instance.public_instance[*]
}