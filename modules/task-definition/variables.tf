variable "task_definition_family" {
  default = "default_task_desinition_family"
}

variable "service_name" {
  default = "default_service_name"
}

variable "application" {
  type = string
}

variable "docker_tag" {
  default = "latest"
}

variable "cpu" {
  default = 256
}

variable "memory" {
  default = 512
}

variable "repository_url" {
  type = string
}

variable "cluster_id" {}

variable "public_subnet_id" {}

variable "security_group_id" {}