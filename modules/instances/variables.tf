variable "key_pair_name" {}

variable "ami" {}

variable "instance_type" {
    default = "t2.micro"
}

variable "subnet_ids" {
    description = "Subnet ids for instances"
    type        = list(string) 
}

variable "sg_id" {}

variable "user_data" {}
