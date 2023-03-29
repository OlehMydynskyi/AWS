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

variable "pub_subnet_cidrs" {
    description = "CIDR block for public subnet" 
    type        = list(string)
}

variable pr_subnet_cidrs {
    description = "CIDR block for private subnet" 
    type        = list(string)
}

variable "sg_name" {
    description = "Name of security group" 
    default     = "sg_subnet"
}

variable "azs" {
    description = "AZs for subnets" 
    type        = list(string)
}