variable "region" {
  type    = string
  default = "us-west-2" 
}

variable "project_name" {
  type    = string
  default = "terraweek"
}

variable "vpc_cidr" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ingress_ports" {
  type = list(number)
  default = [22, 80]
}
