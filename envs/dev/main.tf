locals {
    user_data = <<-EOT
    mkdir /home/ec2-user/log
    yum update -y &> /home/ec2-user/log
    yum install -y httpd &>> /home/ec2-user/log
    systemctl start httpd &>> /home/ec2-user/log
    system enable httpd &>> /home/ec2-user/log
    echo "<center><h1>Instance whith hostname: HOSTNAME</h1></center>" > /var/www/html/index.txt 2>> /home/ec2-user/log
    sed "s/HOSTNAME/$HOSTNAME/" /var/www/html/index.txt > /var/www/html/index.html 2>> /home/ec2-user/log
    EOT
}

module "network" {
    source = "../../modules/network"

    vpc_name        = "Main-VPC"
    vpc_cidr        = "10.0.0.0/16"
    pub_subnet_name = "Public-subnet-1"
    pub_subnet_cidr = "10.0.1.0/24"
    sg_name         = "main_sg"
}

module "EC2" {
    source = "../../modules/instances"

    inst_name     = "Pub-instance-1"
    ami           = "ami-0499632f10efc5a62"
    instance_type = "t2.micro"
    key_pair_name = "Frankfurt-key"
    subnet_id     = module.network.public_subnet_id
    sg_id         = [module.network.sg_id]
    user_data     = "./user_data/aws-cli-run-instances"
}