variable "key_pair_name" {}

variable "ami" {}

variable "instance_type" {
    default = "t2.micro"
}

variable "public_subnet_ids" {
    description = "List of subnet ids for public instances"
    type        = list(string) 
}

variable "private_subnet_ids" {
    description = "List of subnet ids for private instances"
    type        = list(string) 
}

variable "instance_name" {
    description = "Name if instance"
    default     = "Instance"
    type        = string
}

variable "sg_id" {}

variable "user_data" {}
