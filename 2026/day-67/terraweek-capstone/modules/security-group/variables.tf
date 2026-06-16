variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "ingress_ports" {
  description = "List of allowed inbound ports"
  type        = list(number)
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}
