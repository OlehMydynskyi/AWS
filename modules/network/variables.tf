variable "vpc_cidr" {
    description = "CIDR block for VPC" 
}

variable "instance_tenancy" {
    description = "A tenancy option for instances launched into the VPC" 
    default     = "default"
}

variable "vpc_name" {
    description = "VPC`s tag value for key 'NAME'" 
    default     = "my-vpc"
}

variable "pub_subnet_name" {
    description = "Public subnet`s tag value for key 'NAME'" 
    default     = "my-public-subnet"
}

variable "pub_subnet_cidr" {
    description = "CIDR block for public subnet" 
}

variable "sg_name" {
    description = "Name of security group" 
    default     = "sg_subnet"
}