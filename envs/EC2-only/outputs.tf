output "instance_public_ips" {
    value = module.EC2.public_instance[*].public_ip
}