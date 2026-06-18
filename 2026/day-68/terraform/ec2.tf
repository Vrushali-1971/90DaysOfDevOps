resource "aws_key_pair" "ssh_key" {

  key_name   = "ansible"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "my_instance" {
  for_each = var.instances

  ami             = each.value.ami
  instance_type   = each.value.instance_type
  key_name        = aws_key_pair.ssh_key.key_name
  security_groups = [aws_security_group.ansible_lab.name]

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name      = each.key
    OSFamily  = each.value.os_family
    ManagedBy = "terraform"
    Project   = "ansible-training"
  }

  depends_on = [aws_security_group.ansible_lab, aws_key_pair.ssh_key]
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "ansible_lab" {
  name        = "ansible-lab-sg"
  description = "Security group for Ansible lab instances"
  vpc_id      = aws_default_vpc.default.id

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "Common Security Group"
    ManagedBy = "Terraform"
  }
}
