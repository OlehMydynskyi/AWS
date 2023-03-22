module "network" {
    source = "../../modules/network"

    vpc_name          = "Main-VPC"
    vpc_cidr          = "10.0.0.0/16"
    pub_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
    azs               = ["${var.region}a", "${var.region}b"]
    sg_name           = "main_sg"
}

/*module "EC2" {
    source = "../../modules/instances"

    ami           = "ami-0499632f10efc5a62"
    instance_type = "t2.micro"
    key_pair_name = "Frankfurt-key"
    subnet_ids    = module.network.public_subnet_id
    sg_id         = [module.network.sg_id]
    user_data     = "user_data/aws-cli-run-instances"
}*/