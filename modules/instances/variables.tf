variable "key_pair_name" {}

variable "ami" {}

variable "instance_type" {
    default = "t2.micro"
}

variable "inst_name" {
    description = "Instanse`s tag value for key 'NAME'"
}

variable "subnet_id" {}

variable "sg_id" {}

variable "user_data" {}
