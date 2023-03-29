module "network" {
    source = "../../modules/network"

    vpc_name          = "Main-VPC"
    vpc_cidr          = "10.0.0.0/16"
    pub_subnet_cidrs  = ["10.0.11.0/24", "10.0.12.0/24"]
    pr_subnet_cidrs   = ["10.0.21.0/24", "10.0.22.0/24"]
    azs               = ["${var.region}a", "${var.region}b"]
    sg_name           = "main_sg"
}

module "EC2" {
    source = "../../modules/instances"

    ami                = "ami-0499632f10efc5a62"
    instance_type      = "t2.micro"
    key_pair_name      = "Frankfurt-key"
    public_subnet_ids  = module.network.public_subnet_id
    private_subnet_ids = module.network.private_subnet_id
    sg_id              = [module.network.sg_id]
    user_data          = "user_data/aws-cli-run-instances"
}