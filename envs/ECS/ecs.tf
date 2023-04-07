module "network" {
    source = "../../modules/network"

    vpc_name          = "Main-VPC"
    vpc_cidr          = "10.0.0.0/16"
    pub_subnet_cidrs  = ["10.0.11.0/24"]
    azs               = ["${var.region}a"]
    sg_name           = "main_sg"
}

module "cluster" {
    source = "../../modules/ecs-cluster"

    cluster_name = "Main-cluster"
}

module "task" {
    source = "../../modules/task-definition"

    repository_url         = "httpd"
    application            = "first-container"
    task_definition_family = "task-definition" 
    service_name           = "first-service"
    cluster_id             = module.cluster.cluster_id
    public_subnet_id       = module.network.public_subnet_id
    security_group_id      = module.network.sg_id 
}