variable "vpc_cidr" { 
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "Public subnet CIDR block for the VPC"
}

variable "environment" {
  type        = string
  description = "Environment name ( dev, staging, prod)"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

