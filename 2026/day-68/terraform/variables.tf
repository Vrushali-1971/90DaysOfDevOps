variable "region" {
  type    = string
  default = "us-west-2"
}

variable "instances" {
  description = "Map of instance names to AMI IDs, SSH users, and OS family and instance_type"

  type = map(object({
    ami           = string
    user          = string
    os_family     = string
    instance_type = string
  }))

  default = {
    "control-node" = {
      ami           = "ami-096f5760b00bcd95c"
      user          = "ubuntu"
      os_family     = "ubuntu"
      instance_type = "t3.micro"
    }

    "web-server" = {
      ami           = "ami-096f5760b00bcd95c"
      user          = "ubuntu"
      os_family     = "ubuntu"
      instance_type = "t3.micro"
    }

    "app-server" = {
      ami           = "ami-096f5760b00bcd95c"
      user          = "ubuntu"
      os_family     = "ubuntu"
      instance_type = "t3.micro"
    }

    "db-server" = {
      ami           = "ami-096f5760b00bcd95c"
      user          = "ubuntu"
      os_family     = "ubuntu"
      instance_type = "t3.micro"
    }
  }

}


variable "allowed_ports" {
  description = "List of allowed inbound TCP ports"
  type        = list(number)
  default     = [22, 80]
}
